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
#
# Indexes
#
#  index_books_on_googlebooksapi_id                            (googlebooksapi_id) UNIQUE
#  index_books_on_user_id_and_created_at_and_author_and_title  (created_at,author,title)
#

class Book < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :questions, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :authors, dependent: :destroy

  validates :title, presence: true, length: { maximum: 255 }
  validates :googlebooksapi_id, presence: true,
                                length: { maximum: 255 },
                                uniqueness: { case_sensitive: false }
end
