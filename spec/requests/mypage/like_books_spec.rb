require 'rails_helper'

RSpec.describe 'LikeBooks', type: :request do
  it 'いいねした本の画面の取得に成功すること' do
    login
    get '/mypage/like_books'
    expect(response).to have_http_status(200)
  end
end
