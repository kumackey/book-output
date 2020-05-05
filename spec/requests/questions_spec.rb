require 'rails_helper'

RSpec.describe "Questions", type: :request do
  it 'ランダムにクイズが表示できること' do
    create(:question)
    get "/questions/random"
    expect(response).to have_http_status(302)
    follow_redirect!
    expect(response.body).to include("作者")
  end

  it 'クイズ一覧画面の表示に成功すること' do
    get "/questions"
    expect(response).to have_http_status(200)
  end

  it '適切なparamsが渡っているときにクイズが作成できること' do
    login
    user = create(:user)
    book = GoogleBook.new_from_id("4j13KIu3Z60C")
    question_content = "学校補助金の増額案に対する賛成票は、ある投票所では優位に多かった。どこか？"
    expect { post "/books/#{book.googlebooksapi_id}/questions", params: { register_output_form: { 
      question_content: question_content,
      commentary: "プライミング効果によって、学校に対して有利な投票をしたくなるため",
      user_id: user.id,
      book_id: book.googlebooksapi_id,
      correct_choice: "学校",
      incorrect_choice_1: "市役所",
      incorrect_choice_2: "警察署",
      incorrect_choice_3: "美術館",
    } } }.to change{ Question.count }.by(1)
    expect(response).to redirect_to book_path(book.googlebooksapi_id)
  end

  it '不適切なparamsが渡っているときにクイズの作成に失敗すること' do
    login
    user = create(:user)
    book = GoogleBook.new_from_id("4j13KIu3Z60C")
    expect { post "/books/#{book.googlebooksapi_id}/questions", params: { register_output_form: { 
      question_content: nil, # question_contentがない
      commentary: "プライミング効果によって、学校に対して有利な投票をしたくなるため",
      user_id: user.id,
      book_id: book.googlebooksapi_id,
      correct_choice: "学校",
      incorrect_choice_1: "市役所",
      incorrect_choice_2: "警察署",
      incorrect_choice_3: "美術館",
    } } }.to change{ Question.count }.by(0)
    expect(response).to have_http_status(200)
  end

  it 'クイズ作成画面の表示に成功すること' do
    book = GoogleBook.new_from_id("4j13KIu3Z60C")
    login
    get "/books/#{book.googlebooksapi_id}/questions/new"
    expect(response).to have_http_status(200)
  end

  it 'クイズ表示画面の表示に成功すること' do
    question = create(:question, content: "質問しています。")
    get "/questions/#{question.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include("質問しています。")
  end

  it 'クイズの削除に成功すること' do
    user = login
    question = create(:question, user_id: user.id)
    expect { delete "/questions/#{question.id}", xhr: true }.to change{ Question.count }.by(-1)
  end
end

