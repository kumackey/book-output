require 'rails_helper'

RSpec.describe 'Only_answer_quizs', type: :request do
  it 'クイズ作成画面が取得できること' do
    BOOK_TITLE = 'ファスト＆スロー(下)'.freeze
    book = create(:book, title: BOOK_TITLE)
    login
    get "/books/#{book.id}/only_answer_quizs/new"
    expect(response).to have_http_status(200)
    expect(response.body).to include(BOOK_TITLE)
  end
end
