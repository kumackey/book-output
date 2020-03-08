require 'rails_helper'

RSpec.describe RegisterOutputForm, type: :model do
  let(:register_output_form) { build(:register_output_form) } 

  it "有効なファクトリを持つこと" do
    expect(register_output_form).to be_valid
  end

  it "答えの無い出題は無効なこと" do
    register_output_form.answer_number = nil
    expect(register_output_form).not_to be_valid
  end
end
