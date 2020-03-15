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

class Choice < ApplicationRecord
  belongs_to :question
  validates :content, presence: true, length: { maximum: 40 }
end
