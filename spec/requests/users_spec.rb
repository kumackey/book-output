require 'rails_helper'

RSpec.describe "Users", type: :request do
  it "ユーザ作成画面の表示に成功すること" do
    get '/signup'
    expect(response).to have_http_status(200)
  end

  it "ユーザの作成" do
    post '/signup', params: { user: { 
      username: Faker::Name.name,
      email: Faker::Internet.unique.email,
      password: 'password',
      password_confirmation: 'password'
    } }
    expect(response).to redirect_to root_path
  end
end

