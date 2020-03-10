require 'rails_helper'

RSpec.describe "Static_pages", type: :request do
  it "Home画面の取得に成功すること" do
    login
    get '/home'
    expect(response).to have_http_status(200)
    expect(response.body).to include("Home")
  end
end