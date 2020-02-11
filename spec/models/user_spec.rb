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
end
