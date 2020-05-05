require 'rails_helper'

RSpec.describe "Books", type: :request do

  describe "本検索ワードが" do
    context "Railsのときに" do
      keyword = 'Rails'
      it "本検索画面の表示に成功すること" do
        get "/books/search?q%5Bkeyword%5D=#{keyword}"
        expect(response).to have_http_status(200)
        expect(response.body).to include("Ruby") # Railsで調べればRubyが出てくるはず
      end
    end

    context "SREのときに" do
      keyword = 'SRE'
      it "本検索画面の表示に成功すること" do
        get "/books/search?q%5Bkeyword%5D=#{keyword}"
        expect(response).to have_http_status(200)
        expect(response.body).to include("Betsy Beyer") # SREの本を出した人が表示されるはず
      end
    end

    context "Macのときに" do
      keyword = 'Mac'
      it "本検索画面の表示に成功すること" do
        get "/books/search?q%5Bkeyword%5D=#{keyword}"
        expect(response).to have_http_status(200)
        expect(response.body).to include("Mac OS")
      end
    end

    context "検索結果を返すワードでないとき" do
      keyword = 'p6GwxNed' # 適当
      it "本検索画面の表示に成功すること" do
        get "/books/search?q%5Bkeyword%5D=#{keyword}"
        expect(response).to have_http_status(200)
      end
    end
  end

  it '本詳細画面の表示に成功すること' do
    book_title = "ファスト＆スロー(下)"
    book = GoogleBook.search(book_title).first
    get "/books/#{book.googlebooksapi_id}" # ファスト＆スロー(下)のページにアクセス
    expect(response).to have_http_status(200)
  end
end

