class GoogleBook
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :googlebooksapi_id, :string
  attribute :author, :string
  attribute :authors
  attribute :buy_link, :string
  attribute :description, :string
  attribute :image, :string
  attribute :published_at, :date
  attribute :title, :string
  attribute :publisher, :string
  attribute :web_reader_link, :string
  attribute :page_count, :integer

  class << self
    include GoogleBooksApi

    def new_form_item(item)
      @item = item
      @volume_info = @item['volumeInfo']
      new(
        googlebooksapi_id: @item['id'],
        author: @volume_info['authors']&.first,
        authors: @volume_info['authors'],
        buy_link: @item['saleInfo']['buyLink'],
        description: @volume_info['description'],
        image: image_url,
        published_at: @volume_info['publishedDate'],
        title: @volume_info['title'],
        publisher: @volume_info['publisher'],
        web_reader_link: reader_link_url,
        page_count: @volume_info['pageCount'],
      )
    end

    def new_from_id(googlebooksapi_id)
      url = url_of_creating_from_id(googlebooksapi_id)
      item = get_json_from_url(url)
      new_form_item(item)
    end

    def search(keyword)
      url = url_of_searching_from_keyword(keyword)
      json = get_json_from_url(url)
      items = json['items']
      books = []
      items&.each do |item|
        books << GoogleBook.new_form_item(item)
      end
      books
    end

    private

    def image_url
      if @volume_info['imageLinks']
        @volume_info['imageLinks']['smallThumbnail']
      else
        ''
      end
    end

    def reader_link_url
      @item['accessInfo']['webReaderLink'] if @item['accessInfo']
    end
  end

  def image?
    image.present? ? true : false
  end

  def save
    book = build_book
    book.remote_image_url = self.image if self.image.present?
    book.save
    authors.each.with_index do |author, index|
      author = book.authors.build(name: author)
      author.is_representation = index.zero?
      author.save
    end
    true
  end

  private

  def build_book
    Book.new(
      author: author,
      description: description,
      googlebooksapi_id: googlebooksapi_id,
      published_at: published_at,
      title: title,
      buy_link: buy_link
    )
  end
end
