# == Schema Information
#
# Table name: questions
#
#  id          :bigint           not null, primary key
#  answer_type :integer          not null
#  commentary  :text(65535)
#  content     :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  book_id     :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_questions_on_book_id  (book_id)
#  index_questions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#

class Question < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :choices, dependent: :destroy
  has_one :answer, dependent: :destroy

  enum answer_type: {
    choices: 0, #  2〜4択クイズ
    only_answer: 1 #  問題と解答だけのクイズで、「答えられた」「答えられなかった」を回答
  }

  validates :content, presence: true, length: { maximum: 140 }
  validates :commentary, length: { maximum: 255 }
end
