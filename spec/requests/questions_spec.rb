require 'rails_helper'

RSpec.describe 'Questions', type: :request do
  it 'ランダムにクイズが表示できること' do
    create(:question)
    get '/questions/random'
    expect(response).to have_http_status(302)
    follow_redirect!
    expect(response.body).to include('作者')
  end

  it 'クイズ一覧画面の表示に成功すること' do
    get '/questions'
    expect(response).to have_http_status(200)
  end

  it 'クイズ出題画面の表示に成功すること' do
    question = create(:question, content: '質問しています。')
    get "/questions/#{question.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include('質問しています。')
  end

  it '記述式のクイズ出題画面の表示に成功すること' do
    QUESTION_CONTENT = 'hogehoge'.freeze
    build(:create_quiz_description_form, question_content: QUESTION_CONTENT).save
    question = Question.find_by(content: QUESTION_CONTENT)
    get "/questions/#{question.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include('解答を見る')
    expect(response.body).to include(QUESTION_CONTENT)
  end

  it 'クイズの削除に成功すること' do
    user = login
    question = create(:question, user_id: user.id)
    expect { delete "/questions/#{question.id}", xhr: true }.to change { Question.count }.by(-1)
  end
end
