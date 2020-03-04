# == Schema Information
#
# Table name: books
#
#  id                :bigint           not null, primary key
#  author            :string(255)      not null
#  buyLink           :string(255)
#  description       :text(65535)
#  image             :string(255)
#  published_at      :date
#  title             :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  googlebooksapi_id :string(255)      not null
#  user_id           :bigint
#
# Indexes
#
#  index_books_on_googlebooksapi_id                            (googlebooksapi_id) UNIQUE
#  index_books_on_user_id                                      (user_id)
#  index_books_on_user_id_and_created_at_and_author_and_title  (user_id,created_at,author,title)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Book < ApplicationRecord
  include GoogleBooksApi #app/lib
  mount_uploader :image, ImageUploader
  belongs_to :user

  validates :author, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :googlebooksapi_id, presence: true, length: { maximum: 255 }

  def self.hash_from_id(googlebooksapi_id)
    book = GoogleBook.new(googlebooksapi_id)
    {
      author: book.author,
      description: book.description,
      remote_image_url: book.image,
      googlebooksapi_id: book.googlebooksapi_id,
      published_at: book.published_at,
      title: book.title,
      buyLink: book.buyLink,
    }
  end
end
