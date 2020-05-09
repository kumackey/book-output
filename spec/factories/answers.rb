# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  content     :text(65535)      not null
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

FactoryBot.define do
  factory :answer do
    content { 'これが答えです' }
    association :question
  end
end
