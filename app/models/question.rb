# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  commentary :text(65535)
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :string(255)
#  user_id    :bigint
#
# Indexes
#
#  index_questions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Question < ApplicationRecord
  belongs_to :user
  belongs_to :book, optional: true
  has_many :choices, dependent: :destroy

  validates :content, presence: true, length: { maximum: 140 }
  validates :commentary, length: { maximum: 140 }

  def google_book
    GoogleBook.new_from_id(book_id)
  end
end
