require 'rails_helper'

RSpec.describe "Users", type: :request do
  it "ユーザ作成画面の表示に成功すること" do
    get '/signup'
    expect(response).to have_http_status(200)
    expect(response.body).to include("ユーザー登録")
  end

  it "ユーザの作成を行えること" do
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
end

