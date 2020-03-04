module GoogleBooksApi
  def get_json_from_url(url)
    JSON.parse(Net::HTTP.get(URI.parse(Addressable::URI.encode(url))))
  end

  def url_of_searching_from_keyword(keyword)
    "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP&maxResults=20"
  end

  def url_of_creating_from_id(googlebooksapi_id)
    "https://www.googleapis.com/books/v1/volumes/#{googlebooksapi_id}"
  end

  class GoogleBook
    attr_reader :googlebooksapi_id, :author, :buy_link, :description, :image, :published_at, :title, :url

    class << self
      include GoogleBooksApi
      def new_from_id(googlebooksapi_id)
        @url = url_of_creating_from_id(googlebooksapi_id) # ここのurlは効いているか不明
        item = get_json_from_url(@url)
        new(item)
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

    private

    def get_json_from_url(url)
      JSON.parse(Net::HTTP.get(URI.parse(Addressable::URI.encode(url))))
    end

    def retrieve_attribute
      @googlebooksapi_id = @item['id']
      @author = @volume_info['authors'].first if @volume_info['authors']
      @buy_link = @item['saleInfo']['buyLink']
      @description = @volume_info['description']
      @image = @volume_info['imageLink'] # 修正予定
      @published_at = @volume_info['publishedDate']
      @title = @volume_info['title']
    end
  end
end