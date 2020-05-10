require 'rails_helper'

RSpec.describe 'AnswerDescriptions', type: :request do
  it '記述式のクイズの解答画面を取得できること' do
    ANSWER_CONTENT = 'これが答えです'.freeze
    build(:create_quiz_description_form, answer_content: ANSWER_CONTENT).save
    answer_description = AnswerDescription.find_by(content: ANSWER_CONTENT)
    get "/answer_descriptions/#{answer_description.id}"
    expect(response).to have_http_status(200)
    expect(response.body).to include(ANSWER_CONTENT)
  end
end
