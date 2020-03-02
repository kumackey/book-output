require 'rails_helper'

RSpec.describe "Users", type: :request do
  it "ユーザ作成画面の表示に成功すること" do
    get '/signup'
    expect(response).to have_http_status(200)

    get '/users/new'
    expect(response).to have_http_status(200)
  end
end

