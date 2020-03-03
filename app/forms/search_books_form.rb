class SearchBooksForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string
  attribute :author, :string
  attribute :remote_image_url, :string
  attribute :googlebooksapi_id, :string
  attribute :title, :string
  attribute :buyLink, :string

  # carriorwaveのメソッドに合わせた
  def image?
    true if remote_image_url.present?
  end

  def self.hash_from_volume(volume)
    {
      author: Book.author(volume),
      remote_image_url: Book.image_url(volume),
      googlebooksapi_id: volume['id'],
      title: volume['volumeInfo']['title'],
      buyLink: volume['saleInfo']['buyLink']
    }
  end

  def self.url_of_searching_from_keyword(keyword)
    "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP&maxResults=20"
  end
end
