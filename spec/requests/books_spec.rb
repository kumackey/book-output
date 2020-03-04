require 'rails_helper'

RSpec.describe "Books", type: :request do
  it '本一覧画面の表示に成功すること' do
    get '/books'
    expect(response).to have_http_status(200)
  end

  it "本を登録したときにしたときに本一覧画面に追加されていること" do
    get '/books'
    expect(response.body).to_not include("ファスト＆スロー(下)")

    create(:book, title: "ファスト＆スロー(下)")
    get '/books'
    expect(response.body).to include("ファスト＆スロー(下)")
  end

  it '本検索画面の表示に成功すること' do
    get '/books/search'
    expect(response).to have_http_status(200)
  end


  describe "本検索ワードが" do
    context "Railsのときに" do
      keyword = 'Rails'
      it "本検索画面の表示に成功すること" do
        get "/books/search?q%5Bkeyword%5D=#{keyword}"
        expect(response).to have_http_status(200)
        expect(response.body).to include("Ruby") # Railsで調べればRubyが出てくるはず
      end
    end

    context "worldのときに" do
      keyword = 'world'
      it "本検索画面の表示に成功すること" do
        get "/books/search?q%5Bkeyword%5D=#{keyword}"
        expect(response).to have_http_status(200)
        expect(response.body).to include("Hello")
      end
    end

    context "Lambdaのときに" do
      keyword = 'Lambda'
      it "本検索画面の表示に成功すること" do
        get "/books/search?q%5Bkeyword%5D=#{keyword}"
        expect(response).to have_http_status(200)
        expect(response.body).to include("AWS")
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

    context "検索結果を返すワードでないとき" do
      keyword = 'p6GwxNed' # 適当
      it "本検索画面の表示に成功すること" do
        get "/books/search?q%5Bkeyword%5D=#{keyword}"
        expect(response).to have_http_status(200)
      end
    end
  end


  it '本詳細画面の表示に成功すること' do
    book = create(:book)
    get "/books/#{book.id}"
    expect(response).to have_http_status(200)
  end

  it '本詳細画面はその本の情報が載っていること' do
    book = create(:book, title: "ファスト＆スロー(下)")
    create(:other_book, title: "影響力の武器")

    get "/books/#{book.id}" # ファスト＆スロー(下)のページにアクセス
    expect(response.body).to include("ファスト＆スロー(下)")
    expect(response.body).not_to include("影響力の武器")
  end
end

