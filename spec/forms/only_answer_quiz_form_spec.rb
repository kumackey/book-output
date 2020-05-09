require 'rails_helper'

RSpec.describe OnlyAnswerQuizForm, type: :model do
  let(:only_answer_quiz_form) { build(:only_answer_quiz_form) }

  it '有効なファクトリを持つこと' do
    expect(only_answer_quiz_form).to be_valid
  end

  it '質問文が無い時に無効なこと' do
    only_answer_quiz_form = build(:only_answer_quiz_form, question_content: nil)
    only_answer_quiz_form.valid?
    expect(only_answer_quiz_form.errors.messages[:question_content]).to include('を入力してください')
  end

  it '本が無い時に無効なこと' do
    only_answer_quiz_form = build(:only_answer_quiz_form, book_id: nil)
    only_answer_quiz_form.valid?
    expect(only_answer_quiz_form.errors.messages[:book_id]).to include('を入力してください')
  end

  it '投稿者が無い時に無効なこと' do
    only_answer_quiz_form = build(:only_answer_quiz_form, user_id: nil)
    only_answer_quiz_form.valid?
    expect(only_answer_quiz_form.errors.messages[:user_id]).to include('を入力してください')
  end

  describe '解説文が' do
    context '無くとも' do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, commentary: nil) }
      it '有効なこと' do
        expect(only_answer_quiz_form).to be_valid
      end
    end
    COMMENTARY_MAX_WORD_COUNT = 255
    context "#{COMMENTARY_MAX_WORD_COUNT}文字のときに" do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, commentary: 'a' * COMMENTARY_MAX_WORD_COUNT) }
      it '有効なこと' do
        expect(only_answer_quiz_form).to be_valid
      end
    end
    context "#{COMMENTARY_MAX_WORD_COUNT + 1}文字のときに" do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, commentary: 'a' * (COMMENTARY_MAX_WORD_COUNT + 1)) }
      it '無効なこと' do
        only_answer_quiz_form.valid?
        expect(only_answer_quiz_form.errors.messages[:commentary]).to include("は#{COMMENTARY_MAX_WORD_COUNT}文字以内で入力してください")
      end
    end
  end

  describe '問題文が' do
    context '無いときに' do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, question_content: nil) }
      it '無効なこと' do
        only_answer_quiz_form.valid?
        expect(only_answer_quiz_form.errors.messages[:question_content]).to include('を入力してください')
      end
    end
    QUESTION_MAX_WORD_COUNT = 140
    context "#{QUESTION_MAX_WORD_COUNT}文字のときに" do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, question_content: 'a' * QUESTION_MAX_WORD_COUNT) }
      it '有効なこと' do
        expect(only_answer_quiz_form).to be_valid
      end
    end
    context "#{QUESTION_MAX_WORD_COUNT + 1}文字のときに" do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, question_content: 'a' * (QUESTION_MAX_WORD_COUNT + 1)) }
      it '無効なこと' do
        only_answer_quiz_form.valid?
        expect(only_answer_quiz_form.errors.messages[:question_content]).to include("は#{QUESTION_MAX_WORD_COUNT}文字以内で入力してください")
      end
    end
  end

  describe '解答が' do
    context '無いときに' do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, answer_content: nil) }
      it '無効なこと' do
        only_answer_quiz_form.valid?
        expect(only_answer_quiz_form.errors.messages[:answer_content]).to include('を入力してください')
      end
    end
    ANSWER_MAX_WORD_COUNT = 40
    context "#{QUESTION_MAX_WORD_COUNT}文字のときに" do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, answer_content: 'a' * ANSWER_MAX_WORD_COUNT) }
      it '有効なこと' do
        expect(only_answer_quiz_form).to be_valid
      end
    end
    context "#{ANSWER_MAX_WORD_COUNT + 1}文字のときに" do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, answer_content: 'a' * (ANSWER_MAX_WORD_COUNT + 1)) }
      it '無効なこと' do
        only_answer_quiz_form.valid?
        expect(only_answer_quiz_form.errors.messages[:answer_content]).to include("は#{ANSWER_MAX_WORD_COUNT}文字以内で入力してください")
      end
    end
  end

  describe '保存時に' do
    context '適切な情報を持っているときに' do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form) }
      it '保存できること' do
        expect { only_answer_quiz_form.save }.to change { Question.count }.by(1).and change { Answer.count }.by(1)
      end

      it 'trueを返すこと' do
        expect(only_answer_quiz_form.save).to be_truthy
      end
    end
    context '不適切な情報しか持っていないときに' do
      let(:only_answer_quiz_form) { build(:only_answer_quiz_form, answer_content: nil) }
      it '保存に失敗すること' do
        expect { only_answer_quiz_form.save }.to change { Question.count }.by(0).and change { Answer.count }.by(0)
      end

      it 'falseを返すこと' do
        expect(only_answer_quiz_form.save).not_to be_truthy
      end
    end
  end
end
