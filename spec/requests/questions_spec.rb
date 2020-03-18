require 'rails_helper'

RSpec.describe "Questions", type: :request do
  it 'クイズ一覧画面の表示に成功すること' do
    get "/questions"
    expect(response).to have_http_status(200)
  end

  it 'クイズ作成画面の表示に成功すること' do
    book = create(:book, title: "ファスト＆スロー(下)")
    login
    get "/books/#{book.id}/questions/new"
    expect(response).to have_http_status(200)
    expect(response.body).to include("ファスト＆スロー(下)")
  end

  it 'クイズ表示画面の表示に成功すること' do
    question = create(:question, content: "質問しています。")
    get "/questions/#{question.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include("質問しています。")
  end
end

