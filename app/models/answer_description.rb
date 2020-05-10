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

class AnswerDescription < ApplicationRecord
  belongs_to :question

  validates :content, presence: true, length: { maximum: 40 }
end
