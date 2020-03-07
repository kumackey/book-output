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
#  index_likes_on_book_id              (book_id)
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_book_id  (user_id,book_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Like, type: :model do
  it "有効なファクトリを持つこと" do
    like = build(:like)
    expect(like).to be_valid
  end

  it "本の無いいいねは無効なこと" do
    like = build(:like, book_id: nil)
    expect(like).not_to be_valid
  end
end
