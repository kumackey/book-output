require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  it '作成したクイズ一覧の画面の取得に成功すること' do
    login
    get '/mypage/questions'
    expect(response).to have_http_status(200)
  end
end
