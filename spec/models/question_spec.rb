# == Schema Information
#
# Table name: questions
#
#  id          :bigint           not null, primary key
#  answer_type :integer          not null
#  commentary  :text(65535)
#  content     :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  book_id     :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_questions_on_book_id  (book_id)
#  index_questions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { build(:question) }

  it '有効なファクトリを持つこと' do
    expect(question).to be_valid
  end

  it '問題文が空白であるときに無効なこと' do
    question.content = nil
    question.valid?
    expect(question.errors.messages[:content]).to include('を入力してください')
  end

  describe '問題文の文字数が' do
    context '140文字のときに' do
      let(:question) { build(:question, content: 'a' * 140) }
      it '有効なこと' do
        expect(question).to be_valid
      end
    end
    context '141文字のときに' do
      let(:question) { build(:question, content: 'a' * 141) }
      it '無効なこと' do
        question.valid?
        expect(question.errors[:content]).to include('は140文字以内で入力してください')
      end
    end
  end

  it '解説文が空白でも有効なこと' do
    question.commentary = nil
    expect(question).to be_valid
  end

  describe '解説文の文字数が' do
    COMMENTARY_MAX_WORD_COUNT = 255
    context "#{COMMENTARY_MAX_WORD_COUNT}文字のときに" do
      let(:question) { build(:question, commentary: 'a' * COMMENTARY_MAX_WORD_COUNT) }
      it '有効なこと' do
        expect(question).to be_valid
      end
    end
    context "#{COMMENTARY_MAX_WORD_COUNT + 1}文字のときに" do
      let(:question) { build(:question, commentary: 'a' * (COMMENTARY_MAX_WORD_COUNT + 1)) }
      it '無効なこと' do
        question.valid?
        expect(question.errors[:commentary]).to include("は#{COMMENTARY_MAX_WORD_COUNT}文字以内で入力してください")
      end
    end
  end

  it 'クイズの型が存在しないときに無効なこと' do
    question = build(:question, answer_type: nil)
    question.valid?
    expect(question.errors.messages[:answer_type]).to include('を入力してください')
  end
end
