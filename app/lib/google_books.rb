module GoogleBooks
  def get_json_from_url(url)
    # 消したい
    JSON.parse(Net::HTTP.get(URI.parse(Addressable::URI.encode(url))))
  end

  def url_of_searching_from_keyword(keyword)
    "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP&maxResults=20"
  end

  class Volume
    attr_reader :id, :author, :buyLink, :description, :image, :published_at, :title, :url

    def initialize(id)
      @id = id
      @url = url_of_creating_from_id(@id)
      @item = get_json_from_url(@url)
      @volume_info = @item['volumeInfo']
      retrieve_attribute
    end

    private

    def url_of_creating_from_id(googlebooksapi_id)
      "https://www.googleapis.com/books/v1/volumes/#{googlebooksapi_id}"
    end

    def get_json_from_url(url)
      JSON.parse(Net::HTTP.get(URI.parse(Addressable::URI.encode(url))))
    end

    def retrieve_attribute
      @id = @item['id']
      @author = @volume_info['authors'].first
      @buyLink = @item['saleInfo']['buyLink']
      @description = @volume_info['description']
      @image = @volume_info['imageLink'] #修正予定
      @published_at = @volume_info['publishedDate']
      @title = @volume_info['title']
    end
  end
end
