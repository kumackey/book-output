require 'rails_helper'

RSpec.describe OnlyAnswerQuizForm, type: :model do
  let(:only_answer_quiz_form) { build(:only_answer_quiz_form) }

  it '有効なファクトリを持つこと' do
    expect(only_answer_quiz_form).to be_valid
  end

  it '質問文が無い時に無効なこと' do
    only_answer_quiz_form.question_content = nil
    expect(only_answer_quiz_form).not_to be_valid
  end

  it '本が無い時に無効なこと' do
    only_answer_quiz_form.book_id = nil
    expect(only_answer_quiz_form).not_to be_valid
  end

  it '投稿者が無い時に無効なこと' do
    only_answer_quiz_form.user_id = nil
    expect(only_answer_quiz_form).not_to be_valid
  end

  describe '解説文が' do
    context '無くとも' do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, commentary: nil) }
      it '有効なこと' do
        expect(only_answer_quiz_form).to be_valid
      end
    end
    context '255文字のときに' do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, commentary: 'a' * 255) }
      it '有効なこと' do
        expect(only_answer_quiz_form).to be_valid
      end
    end
    context '256文字のときに' do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, commentary: 'a' * 256) }
      it '無効なこと' do
        expect(only_answer_quiz_form).not_to be_valid
      end
    end
  end

  it '問題文が141文字のときに無効なこと' do
    only_answer_quiz_form.question_content = 'a' * 141
    expect(only_answer_quiz_form).not_to be_valid
  end
end
