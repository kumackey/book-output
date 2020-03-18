require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  it "ログイン時にプロフィール画面の表示に成功すること" do
    login
    get "/mypage/account/edit"
    expect(response).to have_http_status(200)
  end

  it "非ログイン時にプロフィール画面へのアクセスはログイン画面に遷移すること" do
    get "/mypage/account/edit"
    expect(response).to redirect_to login_path
  end

  it "プロフィールの編集に成功すること" do
    login
    put "/mypage/account", params: { user: { 
      username: '新しい名前',
    } }
    expect(response).to redirect_to edit_mypage_account_path
    follow_redirect!
    expect(response.body).to include("新しい名前")
  end
end

