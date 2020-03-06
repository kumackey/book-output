# == Schema Information
#
# Table name: books
#
#  id                :bigint           not null, primary key
#  author            :string(255)
#  buy_link          :string(255)
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
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :outputs, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :googlebooksapi_id, presence: true,
                                length: { maximum: 255 },
                                uniqueness: { case_sensitive: false }

  class << self
    def build_from_user_and_google_book(user, google_book)
      book = user.books.build(
        author: google_book.author,
        description: google_book.description,
        googlebooksapi_id: google_book.googlebooksapi_id,
        published_at: google_book.published_at,
        title: google_book.title,
        buy_link: google_book.buy_link
      )
      book.remote_image_url = google_book.image if google_book.image.present?
      book
    end
  end
end
