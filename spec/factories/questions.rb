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

FactoryBot.define do
  factory :question do
    content { "これは問題文です" }
    commentary { "これは問題文の解説です。" }
    book_id { "W_6FAwAAQBAJ" }
    association :user
  end
end
