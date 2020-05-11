require 'rails_helper'

RSpec.describe 'QuizChoices', type: :request do
  it '適切なパラメータが渡されているときにクイズを作成できること' do
    login
    user = create(:user)
    book = create(:book)
    QUESTION_CONTENT = '学校補助金の増額案に対する賛成票は、ある投票所では優位に多かった。どこか？'.freeze
    expect { post "/books/#{book.id}/quiz_choices", params: { create_quiz_choice_form: {
      question_content: QUESTION_CONTENT,
      commentary: 'プライミング効果によって、学校に対して有利な投票をしたくなるため',
      user_id: user.id,
      book_id: book.id,
      correct_choice: '学校',
      incorrect_choice_1: '市役所',
      incorrect_choice_2: '警察署',
      incorrect_choice_3: '美術館'
    } }
    } .to change { Question.count }.by(1).and change { Choice.count }.by(4)
    expect(response).to redirect_to book
    follow_redirect!
    expect(response.body).to include(QUESTION_CONTENT)
  end

  it '不適切なparamが渡っているときにクイズの作成に失敗すること' do
    login
    user = create(:user)
    book = create(:book)
    expect { post "/books/#{book.id}/quiz_choices", params: { create_quiz_choice_form: {
      question_content: nil, #  question_contentがない
      commentary: 'プライミング効果によって、学校に対して有利な投票をしたくなるため',
      user_id: user.id,
      book_id: book.id,
      correct_choice: '学校',
      incorrect_choice_1: '市役所',
      incorrect_choice_2: '警察署',
      incorrect_choice_3: '美術館'
    } }
    } .to change { Question.count }.by(0).and change { Choice.count }.by(0)
    expect(response).to have_http_status(200)
    expect(response.body).to include('問題の作成に失敗しました')
  end

  it 'クイズ作成画面の表示に成功すること' do
    BOOK_TITLE = 'ファスト＆スロー(下)'.freeze
    book = create(:book, title: BOOK_TITLE)
    login
    get "/books/#{book.id}/quiz_choices/new"
    expect(response).to have_http_status(200)
    expect(response.body).to include(BOOK_TITLE)
  end
end
