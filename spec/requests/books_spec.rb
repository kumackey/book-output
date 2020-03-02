require 'rails_helper'

RSpec.describe "Books", type: :request do
  it '本一覧画面の表示に成功すること' do
    get '/books'
    expect(response).to have_http_status(200)
    expect(response.body).to_not include("ファスト＆スロー(下)")

    create(:book, title: "ファスト＆スロー(下)")
    get '/books'
    expect(response).to have_http_status(200)
    expect(response.body).to include("ファスト＆スロー(下)")
  end

  it '本検索画面の表示に成功すること' do
    get '/books/search'
    expect(response).to have_http_status(200)
  end

  it '本検索後に本検索画面の表示に成功すること' do
    keyword = 'Rails'
    get "/books/search?q%5Bkeyword%5D=#{keyword}"
    expect(response).to have_http_status(200)
    expect(response.body).to include("Ruby") # Railsで調べればRubyが出てくるはず
  end

  it '本詳細画面の表示に成功すること' do
    book1 = create(:book, title: "ファスト＆スロー(下)")
    get "/books/#{book1.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include("ファスト＆スロー(下)")
    
    book2 = create(:other_book, title: "影響力の武器")
    get "/books/#{book2.id}"
    expect(response.body).not_to include("ファスト＆スロー(下)")
    expect(response.body).to include("影響力の武器")
  end
end

