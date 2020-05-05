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

  it '本の登録に成功すること' do
    login
    post '/books', params: { googlebooksapi_id: "xPbRxgEACAAJ" }
    expect(response).to redirect_to books_path
    follow_redirect!
    expect(response.body).to include('本を登録しました')
  end

  it '本詳細画面の表示に成功すること' do
    book = create(:book, title: "ファスト＆スロー(下)")
    create(:other_book, title: "影響力の武器")
    get "/books/#{book.id}" # ファスト＆スロー(下)のページにアクセス
    expect(response).to have_http_status(200)
    expect(response.body).to include("ファスト＆スロー(下)")
    expect(response.body).not_to include("影響力の武器")
  end
end

