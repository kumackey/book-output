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

FactoryBot.define do
  factory :user do
    username  { "ユーザー" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password  { "password" }
    password_confirmation { "password" }
  end

  factory :other_user, class: User do
    username  { "アザーユーザー" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password  { "password" }
    password_confirmation { "password" }
  end
end
