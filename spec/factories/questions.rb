# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  commentary :text(65535)
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#  user_id    :bigint
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

FactoryBot.define do
  factory :question do
    content { "質問しています。" }
    association :book
    association :user
  end
end
