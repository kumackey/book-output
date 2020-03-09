require 'rails_helper'

RSpec.describe "Outputs", type: :request do
  it '問題作成画面の表示に成功すること' do
    book = create(:book, title: "ファスト＆スロー(下)")
    login
    get "/books/#{book.id}/outputs/new"
    expect(response).to have_http_status(200)
    expect(response.body).to include("ファスト＆スロー(下)")
  end

  it '問題表示画面の表示に成功すること' do
    output = create(:output, content: "Outputしています。")
    get "/outputs/#{output.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include("Outputしています。")
  end
end

