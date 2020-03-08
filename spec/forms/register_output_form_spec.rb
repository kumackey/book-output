require 'rails_helper'

RSpec.describe RegisterOutputForm, type: :model do
  let(:register_output_form) { build(:register_output_form) } 

  it "有効なファクトリを持つこと" do
    expect(register_output_form).to be_valid
  end
end
