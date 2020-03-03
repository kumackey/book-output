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
  include GoogleBooks #app/lib
  mount_uploader :image, ImageUploader
  belongs_to :user

  validates :author, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :googlebooksapi_id, presence: true, length: { maximum: 255 }

  def self.hash_from_id(googlebooksapi_id)
    volume = Volume.new(googlebooksapi_id)
    {
      author: volume.author,
      description: volume.description,
      remote_image_url: volume.image,
      googlebooksapi_id: volume.id,
      published_at: volume.published_at,
      title: volume.title,
      buyLink: volume.buyLink,
    }
  end

  def self.image_url(volume)
    if volume['volumeInfo']['imageLinks'] # imageLinksが無く、エラーを起こすことがあるため
      volume['volumeInfo']['imageLinks']['smallThumbnail']
    else
      ''
    end
  end

  def self.author(volume)
    if volume['volumeInfo']['authors']
      volume['volumeInfo']['authors'].first
    else
      volume['volumeInfo']['publisher'] || '-'
    end
  end

  def self.nil_guard_volumeinfo_key(volume, volumeinfo_key)
    volume['volumeInfo'][volumeinfo_key] || ''
  end
end
