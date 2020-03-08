require 'rails_helper'

RSpec.describe RegisterOutputForm, type: :model do
  let(:register_output_form) { build(:register_output_form) } 

  it "有効なファクトリを持つこと" do
    expect(register_output_form).to be_valid
  end

  describe "答えの番号が" do
    context "無いときに" do
      let(:register_output_form) { build(:register_output_form, answer_number: nil) } 
      it "無効なこと" do
        expect(register_output_form).not_to be_valid
      end
    end
    context "0のときに" do
      let(:register_output_form) { build(:register_output_form, answer_number: 0) } 
      it "無効なこと" do
        expect(register_output_form).not_to be_valid
      end
    end
    context "文字のときに" do
      let(:register_output_form) { build(:register_output_form, answer_number: 'Hello') } 
      it "無効なこと" do
        expect(register_output_form).not_to be_valid
      end
    end   
  end

  describe "選択肢の" do
    context "1番目が無いときに" do
      let(:register_output_form) { build(:register_output_form, choice_1: nil) } 
      it "無効なこと" do
        expect(register_output_form).not_to be_valid
      end
    end
    context "2番目が無いときに" do
      let(:register_output_form) { build(:register_output_form, choice_2: nil) } 
      it "無効なこと" do
        expect(register_output_form).not_to be_valid
      end
    end
  end
end
