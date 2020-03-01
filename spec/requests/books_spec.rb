require 'rails_helper'

RSpec.describe "Books", type: :request do
  it '本一覧画面の表示に成功すること' do
    get books_path
    expect(response).to have_http_status(200)
  end

  it '本登録画面の表示に成功すること' do
    get new_book_path
    expect(response).to have_http_status(200)
  end

  it '本検索画面の表示に成功すること' do
    get search_new_book_path
    expect(response).to have_http_status(200)
  end
end

