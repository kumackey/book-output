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

  it '適切なparamが渡っているときにクイズを作成できること' do
    login
    user = create(:user)
    book = create(:book)
    expect { post "/books/#{book.id}/questions", params: { register_output_form: {
      question_content: '学校補助金の増額案に対する賛成票は、ある投票所では優位に多かった。どこか？',
      commentary: 'プライミング効果によって、学校に対して有利な投票をしたくなるため',
      user_id: user.id,
      book_id: book.id,
      correct_choice: '学校',
      incorrect_choice_1: '市役所',
      incorrect_choice_2: '警察署',
      incorrect_choice_3: '美術館'
    } }
    } .to change { Question.count }.by(1)
    expect(response).to redirect_to book
  end

  it '不適切なparamが渡っているときにクイズの作成に失敗すること' do
    login
    user = create(:user)
    book = create(:book)
    expect { post "/books/#{book.id}/questions", params: { register_output_form: {
      question_content: nil, #  question_contentがない
      commentary: 'プライミング効果によって、学校に対して有利な投票をしたくなるため',
      user_id: user.id,
      book_id: book.id,
      correct_choice: '学校',
      incorrect_choice_1: '市役所',
      incorrect_choice_2: '警察署',
      incorrect_choice_3: '美術館'
    } }
    } .to change { Question.count }.by(0)
    expect(response).to have_http_status(200)
    expect(response.body).to include('問題の作成に失敗しました')
  end

  it 'クイズ作成画面の表示に成功すること' do
    book = create(:book, title: 'ファスト＆スロー(下)')
    login
    get "/books/#{book.id}/questions/new"
    expect(response).to have_http_status(200)
    expect(response.body).to include('ファスト＆スロー(下)')
  end

  it 'クイズ表示画面の表示に成功すること' do
    question = create(:question, content: '質問しています。')
    get "/questions/#{question.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include('質問しています。')
  end

  it 'クイズの削除に成功すること' do
    user = login
    question = create(:question, user_id: user.id)
    expect { delete "/questions/#{question.id}", xhr: true }.to change { Question.count }.by(-1)
  end
end
