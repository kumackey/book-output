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

FactoryBot.define do
  factory :output do
    content { "学校補助金の増額案に対する賛成票は、投票所が学校の場合、そうでない場合よりも有意に多かった" }
    association :book
    association :user
  end
end
