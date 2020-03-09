require 'rails_helper'

RSpec.describe "Outputs", type: :request do
  # ログインしてないと不可
  # it '問題作成画面の表示に成功すること' do
  #   book = create(:book)
  #   get "/books/#{book.id}/outputs/new"
  #   expect(response).to have_http_status(200)
  # end

  it '問題表示画面の表示に成功すること' do
    output = create(:output)
    get "/outputs/#{output.id}"
    expect(response).to have_http_status(200)
  end
end

