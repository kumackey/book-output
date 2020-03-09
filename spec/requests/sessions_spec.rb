require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  
  it "ログイン画面の表示に成功すること" do
    get '/login'
    expect(response).to have_http_status(200)
  end

  it "ゲストログインに成功すること" do
    post '/guest_login'
    expect(response).to redirect_to root_path
  end
end