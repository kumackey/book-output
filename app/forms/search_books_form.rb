class SearchBooksForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :author, :string
  attribute :detail, :string
  attribute :image, :string
  attribute :isbn, :integer, :limit => 8   # bigint
  attribute :title, :string
  attribute :published_at, :date

  #isbnのvalidateを追加する
end