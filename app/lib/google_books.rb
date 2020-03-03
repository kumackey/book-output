module GoogleBooks
  def get_json_from_url(url)
    JSON.parse(Net::HTTP.get(URI.parse(Addressable::URI.encode(url))))
  end
end