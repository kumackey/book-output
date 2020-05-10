require 'rails_helper'

describe GoogleBooksApi do
  let(:test_class) { Struct.new(:google_books_api) { include GoogleBooksApi } }
  let(:google_books_api) { test_class.new }

  it '検索するAPIを叩き、複数のデータを返すkindが取得できること' do
    url = google_books_api.url_of_searching_from_keyword('Rails')
    expect(google_books_api.get_json_from_url(url)['kind']).to eq 'books#volumes'
  end

  it 'IDから本の情報を取得するAPIを叩き、特定データを返すkindが取得できること' do
    GOOGLE_BOOKS_API_ID_SAMPLE = 'aB4B13xGEv4C'.freeze
    url = google_books_api.url_of_creating_from_id(GOOGLE_BOOKS_API_ID_SAMPLE)
    expect(google_books_api.get_json_from_url(url)['kind']).to eq 'books#volume'
    expect(google_books_api.get_json_from_url(url)['id']).to eq GOOGLE_BOOKS_API_ID_SAMPLE
  end
end
