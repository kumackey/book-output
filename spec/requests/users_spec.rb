require 'rails_helper'

RSpec.describe "Users", type: :request do
  it "ユーザー作成画面の表示に成功すること" do
    get '/signup'
    expect(response).to have_http_status(200)
    expect(response.body).to include("ユーザー登録")
  end

  it "ユーザーの作成を行えること" do
    post '/signup', params: { user: { 
      username: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: 'password',
      password_confirmation: 'password'
    } }
    expect(response).to redirect_to home_path
    follow_redirect!
    expect(response.body).to include('ユーザーを作成し')
  end

  it "ログイン時にマイページ画面の表示に成功すること" do
    login
    get "/mypage"
    expect(response).to have_http_status(200)
  end

  it "非ログイン時にマイページはログイン画面に遷移すること" do
    get "/mypage"
    expect(response).to redirect_to login_path
  end

  it "ユーザー詳細画面の表示に成功すること" do
    user = create(:user, username: 'サンプルユーザー')
    get "/users/#{user.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include("サンプルユーザー")
  end
end

