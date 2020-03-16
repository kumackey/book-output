require 'rails_helper'

RSpec.describe RegisterOutputForm, type: :model do
  let(:register_output_form) { build(:register_output_form) } 

  it "有効なファクトリを持つこと" do
    expect(register_output_form).to be_valid
  end

  it "質問文が無い時に無効なこと" do
    register_output_form.question_content = nil
    expect(register_output_form).not_to be_valid
  end

  it "そのクイズの本が無い時に無効なこと" do
    register_output_form.book_id = nil
    expect(register_output_form).not_to be_valid
  end

  it "そのクイズの投稿者が無い時に無効なこと" do
    register_output_form.user_id = nil
    expect(register_output_form).not_to be_valid
  end

  it "問題文が141文字のときに無効なこと" do
    register_output_form.question_content = "a" * 141
    expect(register_output_form).not_to be_valid
  end

  describe "選択肢の" do
    context "正答が無いときに" do
      let(:register_output_form) { build(:register_output_form, correct_choice: nil) } 
      it "無効なこと" do
        expect(register_output_form).not_to be_valid
      end
    end
    context "正答が41文字のときに" do
      let(:register_output_form) { build(:register_output_form, correct_choice: "a" * 41) } 
      it "無効なこと" do
        expect(register_output_form).not_to be_valid
      end
    end
    context "1番目の誤答が無いときに" do
      let(:register_output_form) { build(:register_output_form, incorrect_choice_1: nil) } 
      it "無効なこと" do
        expect(register_output_form).not_to be_valid
      end
    end
    context "2,3番目の誤答が無くとも" do
      let(:register_output_form) { build(:register_output_form, incorrect_choice_2: nil, incorrect_choice_3: nil) } 
      it "有効なこと" do
        expect(register_output_form).to be_valid
      end
    end
    context "2番目の誤答が41文字のときに" do
      let(:register_output_form) { build(:register_output_form, incorrect_choice_2: 'a' * 41) } 
      it "無効なこと" do
        expect(register_output_form).not_to be_valid
      end
    end
  end
end
