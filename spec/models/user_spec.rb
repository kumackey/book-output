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

    it "有効なファクトリを持つこと" do
      expect(user).to be_valid
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

      it "重複したメールアドレスなら無効な状態であること" do
        create(:user, email:"duP@example.com")
        user2 = build(:user, email:"Dup@example.com")
        user2.valid?
        expect(user2.errors[:email]).to include("はすでに存在します")
      end
    end
end
