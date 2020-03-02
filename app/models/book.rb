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
  mount_uploader :image, ImageUploader
  belongs_to :user

  validates :author, presence: true, length: { maximum: 255 }

  def self.get_json_from_id(googlebooksapi_id)
    JSON.parse(Net::HTTP.get(URI.parse(URI.escape(
                                         "https://www.googleapis.com/books/v1/volumes/#{googlebooksapi_id}"
                                       ))))
  end

  def self.hash_from_volume(volume)
    {
      author: Book.author(volume),
      description: Book.nil_guard_volumeInfo_key(volume, 'descriptin'),
      remote_image_url: Book.image_url(volume),
      googlebooksapi_id: volume['id'],
      published_at: Book.nil_guard_volumeInfo_key(volume, 'publishedDate'),
      title: volume['volumeInfo']['title'],
      buyLink: volume['saleInfo']['buyLink']
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

  def self.nil_guard_volumeInfo_key(volume, volumeInfo_key)
    volume['volumeInfo'][volumeInfo_key] || ''
  end

  def self.new_from_volume(volume)
    if volume
      new(Book.hash_from_volume(volume))
    else
      new # エラーを返せるようにする
    end
  end
end
