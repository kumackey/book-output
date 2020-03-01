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
end
