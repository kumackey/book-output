# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :string(255)
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_book_id  (user_id,book_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :like do
    association :user
    association :book
  end
end
