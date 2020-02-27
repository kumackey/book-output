class SearchBooksForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :author, :string
  attribute :detail, :string
  attribute :image, :string
  attribute :isbn, :integer
  attribute :title, :string
  attribute :published_at, :datetime

  #isbnのvalidateを追加する
end