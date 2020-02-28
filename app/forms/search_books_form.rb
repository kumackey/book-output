class SearchBooksForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :author, :string
  attribute :image, :string
  attribute :isbn, :integer, :limit => 8   # bigint
  attribute :title, :string
  attribute :googlebooksapi_id, :string
  attribute :published_at, :date
  attribute :description, :string #textに修正したい

  #isbnのvalidateを追加する
end