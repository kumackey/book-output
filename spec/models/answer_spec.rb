# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  content     :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:answer) { build(:answer) }

  it '有効なファクトリを持つこと' do
    expect(answer).to be_valid
  end
end
