# == Schema Information
#
# Table name: choices
#
#  id         :bigint           not null, primary key
#  content    :string(255)      not null
#  is_answer  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  output_id  :bigint
#
# Indexes
#
#  index_choices_on_output_id                (output_id)
#  index_choices_on_output_id_and_is_answer  (output_id,is_answer) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (output_id => outputs.id)
#

require 'rails_helper'

RSpec.describe Choice, type: :model do
  let(:choice) { build(:choice) }

  it "有効なファクトリを持つこと" do
    expect(choice).to be_valid
  end

  it "選択肢の正誤がnilでも有効なこと" do
    choice.is_answer = nil
    expect(choice).to be_valid
  end

  it "選択肢が空白であるときに無効なこと" do
    choice.content = nil
    choice.valid?
    expect(choice.errors.messages[:content]).to include("を入力してください")
  end

  describe "選択肢の文字数が" do
    context "40文字のときに" do
      let(:choice) { build(:choice, content: 'a' * 40) }
      it "有効なこと" do
        expect(choice).to be_valid
      end
    end
    context "41文字のときに" do
      let(:choice) { build(:choice, content: 'a' * 41) }
      it "無効なこと" do
        choice.valid?
        expect(choice.errors[:content]).to include("は40文字以内で入力してください")
      end
    end
  end
end
