# == Schema Information
#
# Table name: books
#
#  id                :bigint           not null, primary key
#  author            :string(255)      not null
#  buyLink           :string(255)
#  description       :text(65535)
#  image             :string(255)
#  published_at      :date
#  title             :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  googlebooksapi_id :string(255)      not null
#  user_id           :bigint
#
# Indexes
#
#  index_books_on_googlebooksapi_id                            (googlebooksapi_id) UNIQUE
#  index_books_on_user_id                                      (user_id)
#  index_books_on_user_id_and_created_at_and_author_and_title  (user_id,created_at,author,title)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :book do
    author  { "ダニエル・カーネマン" }
    description { "我々の直感は間違ってばかり？" }
    image { File.open("#{Rails.root}/spec/factories/fast_and_slow.jpeg") }
    isbn { 9784150504113 }
    published_at { 2013-05-24 }
    title { "ファスト＆スロー(下)" }
    googlebooksapi_id { "yHrxYFWkrfQC" }
    buyLink { "https://play.google.com/store/books/details?id=yHrxYFWkrfQC&rdid=book-yHrxYFWkrfQC&rdot=1&source=gbs_api" }
    association :user
  end
end
