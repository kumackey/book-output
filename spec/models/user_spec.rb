# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  crypted_password :string(255)
#  email            :string(255)      not null
#  salt             :string(255)
#  username         :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:other_user) { build(:other_user) }

  it "有効なファクトリを持つこと" do
    expect(user).to be_valid
    expect(other_user).to be_valid
  end

  it "名前が空白であるときに無効なこと" do
    user.username = '     '
    user.valid?
    expect(user.errors.messages[:username]).to include("を入力してください")
  end

  describe "名前の最大文字数が20文字であること" do
    context "名前が20文字のときに" do
      let(:user) { build(:user, username: 'a' * 20) }
      it "有効なこと" do
        expect(user).to be_valid
      end
    end
    context "名前が21文字のときに" do
      let(:user) { build(:user, username: 'a' * 21) }
      it "無効なこと" do
        user.valid?
        expect(user.errors[:username]).to include("は20文字以内で入力してください")
      end
    end
  end

  it "重複したメールアドレスなら無効なこと" do
    create(:user, email:"duP@example.com")
    user2 = build(:user, email:"Dup@example.com")
    user2.valid?
    expect(user2.errors[:email]).to include("はすでに存在します")
  end

  it "不正な値のメールアドレスは無効なこと" do
    invalid_addresses = %w[user@example,com 
                          user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
  end

  it "ユーザーが消去されたとき、登録されていた本も消えること" do
    owner = create(:user)
    create(:book, user_id: owner.id)
    expect{ owner.destroy }.to change{ Book.count }.by(-1)
  end 

  it "ユーザーが消去されたとき、関連するクイズも消えること" do
    user = create(:user)
    create(:question, user_id: user.id)
    expect{ user.destroy }.to change{ Question.count }.by(-1)
  end 

  it "ユーザがオブジェクトを持っているかを確認する機能own?が有効なこと" do
    user = create(:user)
    other_user = create(:user)
    book = build(:book, user_id: other_user.id)
    expect(user.own?(book)).not_to be_truthy

    book = build(:book, user_id: user.id)
    expect(user.own?(book)).to be_truthy
  end

  it "いいねができること" do
    user = create(:user)
    book = create(:book)
    expect { user.like(book) }.to change{ Like.count }.by(1)
    expect(user.like?(book)).to be_truthy
  end

  it "いいねを外せること" do
    like = create(:like)
    user = like.user
    book = like.book
    expect { user.unlike(book) }.to change{ Like.count }.by(-1)
    expect(user.like?(book)).not_to be_truthy
  end

  it "フィードにいいねした本の問題が載ること" do
    user = create(:user)
    book = create(:book)
    create(:question, book_id: book.id)
    expect { user.like(book) }.to change{ user.feed.count }.by(1)
  end

  it "フィードに自分が作った問題が載ること" do
    user = create(:user)
    expect { create(:question, user_id: user.id) }.to change{ user.feed.count }.by(1)
  end
end
