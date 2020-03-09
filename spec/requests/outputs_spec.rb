require 'rails_helper'

RSpec.describe "Outputs", type: :request do
  it '問題作成画面の表示に成功すること' do
    book = create(:book)
    user = book.user
    login_user(user, 'password', login_path)
    get "/books/#{book.id}/outputs/new"
    expect(response).to have_http_status(200)
  end

  it '問題表示画面の表示に成功すること' do
    output = create(:output)
    get "/outputs/#{output.id}"
    expect(response).to have_http_status(200)
  end
end

