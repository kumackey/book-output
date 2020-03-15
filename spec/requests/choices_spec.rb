require 'rails_helper'

RSpec.describe "Choces", type: :request do
  it '正答すると正解表示が出ること' do
    choice = create(:choice, is_answer: true)
    book = choice.question.book
    get "/choices/#{choice.id}/check"
    expect(response).to redirect_to book
    follow_redirect!
    expect(response.body).to include("正解です！")
  end

  it '誤答すると不正解表示が出ること' do
    choice = create(:choice, is_answer: nil)
    question = choice.question
    get "/choices/#{choice.id}/check"
    expect(response).to redirect_to question
    follow_redirect!
    expect(response.body).to include('残念！不正解です・・・')
  end
end