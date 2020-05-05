# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  avatar           :string(255)
#  crypted_password :string(255)
#  email            :string(255)      not null
#  salt             :string(255)
#  username         :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_many :books, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_books, through: :likes, source: :book

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :username, presence: true, length: { maximum: 20 }
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }

  def own?(object)
    id == object.user_id
  end

  def like_google_book_ids
    likes.all.to_a.map{ |book| book.book_id }
  end

  def like_google_books
    like_google_book_ids.map{ |id| GoogleBook.new_from_id(id) }
  end

  def like_google_book(google_book)
    #　後々likeメソッドに名前を置換したい
    likes.create(book_id: google_book.googlebooksapi_id)
  end

  def unlike_google_book(google_book)
    #　後々unlikeメソッドに名前を置換したい
    like = likes.find_by(book_id: google_book.googlebooksapi_id)
    like.destroy
  end

  def like_google_book?(google_book)
    #　後々like?メソッドに名前を置換したい
    like_google_book_ids.include?(google_book.googlebooksapi_id)
  end

  def like(book)
    like_books << book
  end

  def unlike(book)
    like_books.destroy(book)
  end

  def like?(book)
    like_books.include?(book)
  end

  def feed
    favorite_book_ids = 'SELECT book_id FROM likes WHERE user_id = :user_id'
    Question.where("book_id IN (#{favorite_book_ids}) OR user_id = :user_id", user_id: id)
  end
end
