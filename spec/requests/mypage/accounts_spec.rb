require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  it "ログイン時にマイページ画面の表示に成功すること" do
    login
    get "/mypage/account"
    expect(response).to have_http_status(200)
  end

  it "非ログイン時にマイページはログイン画面に遷移すること" do
    get "/mypage/account"
    expect(response).to redirect_to login_path
  end
end

