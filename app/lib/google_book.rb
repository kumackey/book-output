class GoogleBook
  attr_reader :googlebooksapi_id, :author, :buy_link, :description,
              :image, :published_at, :title, :publisher, :web_reader_link, :page_count

  class << self
    include GoogleBooksApi

    def new_from_id(googlebooksapi_id)
      url = url_of_creating_from_id(googlebooksapi_id)
      item = get_json_from_url(url)
      new(item)
    end

    def search(keyword)
      url = url_of_searching_from_keyword(keyword)
      json = get_json_from_url(url)
      items = json['items']
      books = []
      if items
        items.each do |item|
          books << GoogleBook.new(item)
        end
      end
      books
    end
  end

  def initialize(item)
    @item = item
    @volume_info = @item['volumeInfo']
    retrieve_attribute
  end

  def image?
    image.present? ? true : false
  end

  def retrieve_attribute
    @googlebooksapi_id = @item['id']
    @author = first_author
    @buy_link = @item['saleInfo']['buyLink']
    @description = @volume_info['description']
    @image = image_url
    @published_at = @volume_info['publishedDate']
    @title = @volume_info['title']
    @publisher = @volume_info['publisher']
    @web_reader_link = reader_link_url
    @page_count = @volume_info['pageCount']
  end

  private

  def image_url
    if @volume_info['imageLinks']
      @volume_info['imageLinks']['smallThumbnail']
    else
      ''
    end
  end

  def first_author
    @volume_info['authors']&.first
  end

  def reader_link_url
    @item['accessInfo']['webReaderLink'] if @item['accessInfo']
  end
end
