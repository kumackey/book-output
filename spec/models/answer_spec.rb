# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  content     :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { build(:answer) }

  it '有効なファクトリを持つこと' do
    expect(answer).to be_valid
  end

  describe '解答が' do
    context '存在しないときに' do
      let(:answer) { build(:answer, content: nil) }
      it '無効なこと' do
        answer.valid?
        expect(answer.errors.messages[:content]).to include('を入力してください')
      end
    end
    ANSWER_MAX_WORD_COUNT = 40
    context "#{ANSWER_MAX_WORD_COUNT}文字のときに" do
      let(:answer) { build(:answer, content: 'a' * ANSWER_MAX_WORD_COUNT) }
      it '有効なこと' do
        expect(answer).to be_valid
      end
    end
    context "#{ANSWER_MAX_WORD_COUNT + 1}文字のときに" do
      let(:answer) { build(:answer, content: 'a' * (ANSWER_MAX_WORD_COUNT + 1)) }
      it '無効なこと' do
        answer.valid?
        expect(answer.errors[:content]).to include("は#{ANSWER_MAX_WORD_COUNT}文字以内で入力してください")
      end
    end
  end
end
