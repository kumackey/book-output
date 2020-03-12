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

class Output < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :choices, dependent: :destroy

  validates :content, presence: true, length: { maximum: 500 }
end
