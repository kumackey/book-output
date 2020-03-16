# == Schema Information
#
# Table name: outputs
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_outputs_on_book_id  (book_id)
#  index_outputs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { build(:question) }

  it "有効なファクトリを持つこと" do
    expect(question).to be_valid
  end

  it "アウトプットが空白であるときに無効なこと" do
    question.content = nil
    question.valid?
    expect(question.errors.messages[:content]).to include("を入力してください")
  end

  describe "アウトプットの文字数が" do
    context "500文字のときに" do
      let(:question) { build(:question, content: 'a' * 500) }
      it "有効なこと" do
        expect(question).to be_valid
      end
    end
    context "501文字のときに" do
      let(:question) { build(:question, content: 'a' * 501) }
      it "無効なこと" do
        question.valid?
        expect(question.errors[:content]).to include("は500文字以内で入力してください")
      end
    end
  end
end
