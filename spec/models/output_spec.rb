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

RSpec.describe Output, type: :model do
  let(:output) { build(:output) }

  it "有効なファクトリを持つこと" do
    expect(output).to be_valid
  end

  it "アウトプットが空白であるときに無効なこと" do
    output.content = nil
    output.valid?
    expect(output.errors.messages[:content]).to include("を入力してください")
  end
end
