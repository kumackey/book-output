class SearchBooksForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :keyword, :string
  attribute :author, :string
  attribute :image, :string
  attribute :googlebooksapi_id, :string
  attribute :title, :string
  attribute :buy_link, :string

  class << self
    include GoogleBooksApi
    def search(keyword)
      url = url_of_searching_from_keyword(keyword)
      json = get_json_from_url(url)
      books = []
      if json['items']
        items = json['items']
        books = []
        items.each do |item|
          books << GoogleBook.new(item)
        end
      end
      books
    end
  end
end
