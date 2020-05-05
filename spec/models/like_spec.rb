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
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_book_id  (user_id,book_id) UNIQUE
#
# Foreign Keys
#
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

  it "重複したいいねは無効なこと" do
    like1 = create(:like)
    like2 = build(:like, user_id: like1.user_id, book_id: like1.book_id)
    like2.valid?
    expect(like2.errors[:user_id]).to include("はすでに存在します")
  end
end
