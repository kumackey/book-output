require 'rails_helper'

RSpec.describe CreateQuizChoiceForm, type: :model do
  let(:create_quiz_choice_form) { build(:create_quiz_choice_form) }

  it '有効なファクトリを持つこと' do
    expect(create_quiz_choice_form).to be_valid
  end

  it '質問文が無い時に無効なこと' do
    create_quiz_choice_form.question_content = nil
    expect(create_quiz_choice_form).not_to be_valid
  end

  it 'そのクイズの本が無い時に無効なこと' do
    create_quiz_choice_form.book_id = nil
    expect(create_quiz_choice_form).not_to be_valid
  end

  it 'そのクイズの投稿者が無い時に無効なこと' do
    create_quiz_choice_form.user_id = nil
    expect(create_quiz_choice_form).not_to be_valid
  end

  describe '解説文が' do
    context '無くとも' do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form, commentary: nil) }
      it '有効なこと' do
        expect(create_quiz_choice_form).to be_valid
      end
    end
    COMMENTARY_MAX_WORD_COUNT = 255
    context "#{COMMENTARY_MAX_WORD_COUNT}文字のときに" do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form, commentary: 'a' * COMMENTARY_MAX_WORD_COUNT) }
      it '有効なこと' do
        expect(create_quiz_choice_form).to be_valid
      end
    end
    context "#{COMMENTARY_MAX_WORD_COUNT + 1}文字のときに" do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form, commentary: 'a' * (COMMENTARY_MAX_WORD_COUNT + 1)) }
      it '無効なこと' do
        create_quiz_choice_form.valid?
        expect(create_quiz_choice_form.errors.messages[:commentary]).to include("は#{COMMENTARY_MAX_WORD_COUNT}文字以内で入力してください")
      end
    end
  end

  it '問題文が141文字のときに無効なこと' do
    create_quiz_choice_form.question_content = 'a' * 141
    expect(create_quiz_choice_form).not_to be_valid
  end

  describe '選択肢の' do
    context '正答が無いときに' do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form, correct_choice: nil) }
      it '無効なこと' do
        expect(create_quiz_choice_form).not_to be_valid
      end
    end
    context '正答が41文字のときに' do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form, correct_choice: 'a' * 41) }
      it '無効なこと' do
        expect(create_quiz_choice_form).not_to be_valid
      end
    end
    context '1番目の誤答が無いときに' do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form, incorrect_choice_1: nil) }
      it '無効なこと' do
        expect(create_quiz_choice_form).not_to be_valid
      end
    end
    context '2,3番目の誤答が無くとも' do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form, incorrect_choice_2: nil, incorrect_choice_3: nil) }
      it '有効なこと' do
        expect(create_quiz_choice_form).to be_valid
      end
    end
    context '2番目の誤答が41文字のときに' do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form, incorrect_choice_2: 'a' * 41) }
      it '無効なこと' do
        expect(create_quiz_choice_form).not_to be_valid
      end
    end
  end

  describe '保存時に' do
    context '適切な情報を持っているときに' do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form,
                                            correct_choice: '学校',
                                            incorrect_choice_1: '市役所',
                                            incorrect_choice_2: '警察署',
                                            incorrect_choice_3: '美術館')
      } #  4つの選択肢
      it '保存できること' do
        expect { create_quiz_choice_form.save }.to change { Question.count }.by(1).and change { Choice.count }.by(4)
      end

      it 'trueを返すこと' do
        expect(create_quiz_choice_form.save).to be_truthy
      end
    end
    context '不適切な情報しか持っていないときに' do
      let(:create_quiz_choice_form) { build(:create_quiz_choice_form, correct_choice: nil) }
      it '保存に失敗すること' do
        expect { create_quiz_choice_form.save }.to change { Question.count }.by(0).and change { Choice.count }.by(0)
      end

      it 'falseを返すこと' do
        expect(create_quiz_choice_form.save).not_to be_truthy
      end
    end
  end
end
