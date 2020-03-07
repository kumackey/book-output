# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_book_id  (book_id)
#  index_likes_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :like do
    book nil
    user nil
  end
end
