class SearchBooksForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :author, :string
  attribute :remote_image_url, :string
  attribute :isbn, :integer, limit: 8 # bigint
  attribute :title, :string
  attribute :googlebooksapi_id, :string
  attribute :published_at, :date
  attribute :description, :string # textに修正したい
  attribute :buyLink, :string

  # isbnのvalidateを追加する
end
