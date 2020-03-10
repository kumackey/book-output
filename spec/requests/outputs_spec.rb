require 'rails_helper'

RSpec.describe "Outputs", type: :request do
  it 'クイズ一覧画面の表示に成功すること' do
    get "/outputs"
    expect(response).to have_http_status(200)
  end

  it '最新のクイズへのリダイレクトに成功すること' do
    output = create(:output)
    get "/outputs/latest"
    expect(response).to redirect_to output_path(output)
  end

  it 'クイズ作成画面の表示に成功すること' do
    book = create(:book, title: "ファスト＆スロー(下)")
    login
    get "/books/#{book.id}/outputs/new"
    expect(response).to have_http_status(200)
    expect(response.body).to include("ファスト＆スロー(下)")
  end

  it 'クイズ表示画面の表示に成功すること' do
    output = create(:output, content: "Outputしています。")
    get "/outputs/#{output.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include("Outputしています。")
  end
end

