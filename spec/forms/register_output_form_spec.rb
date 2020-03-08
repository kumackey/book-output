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
  end
end
