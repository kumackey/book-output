require 'rails_helper'

RSpec.describe "Choces", type: :request do
  it '選択肢の回答結果画面の表示に成功すること' do
    login
    choice = create(:choice)
    get "/choices/#{choice.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include("正解")
  end
end