require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  it 'ログイン画面の表示に成功すること' do
    get signup_path
    expect(response).to have_http_status(200)
  end
end