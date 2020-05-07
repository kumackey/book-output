# == Schema Information
#
# Table name: choices
#
#  id          :bigint           not null, primary key
#  content     :string(255)      not null
#  is_answer   :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  output_id   :bigint
#  question_id :bigint
#
# Indexes
#
#  index_choices_on_output_id                  (output_id)
#  index_choices_on_output_id_and_is_answer    (output_id,is_answer) UNIQUE
#  index_choices_on_question_id                (question_id)
#  index_choices_on_question_id_and_is_answer  (question_id,is_answer)
#
# Foreign Keys
#
#  fk_rails_...  (output_id => questions.id)
#

FactoryBot.define do
  factory :choice do
    content { '○' }
    is_answer { true }
    association :question
  end
end
