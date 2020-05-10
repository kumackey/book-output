# == Schema Information
#
# Table name: answer_descriptions
#
#  id          :bigint           not null, primary key
#  content     :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint
#
# Indexes
#
#  index_answer_descriptions_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#

FactoryBot.define do
  factory :answer_description do
    content { 'これが答えです' }
    question_id { create(:question_description).id }
  end
end
