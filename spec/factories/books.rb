# == Schema Information
#
# Table name: books
#
#  id                :bigint           not null, primary key
#  author            :string(255)      not null
#  buyLink           :string(255)
#  description       :text(65535)
#  image             :string(255)
#  isbn              :bigint           not null
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
#  index_books_on_isbn                                         (isbn) UNIQUE
#  index_books_on_user_id                                      (user_id)
#  index_books_on_user_id_and_created_at_and_author_and_title  (user_id,created_at,author,title)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :book do
    author  { "ダニエル カーネマン" }
    detail { "我々の直感は間違ってばかり？　意識はさほど我々の意思決定に影響をおよぼしていない？　心理学者ながらノーベル経済学賞受賞の離れ業を成し遂げ、行動経済学を世界にしらしめた、伝統的人間観を覆す、カーネマンの代表的著作。2012年度最高のノンフィクション。待望の邦訳。" }
    image  { "" } #carriorwave導入予定
    sequence(:isbn) { |n| "#{n}" }
    published_at { "20121122" }
    title { "ファスト＆スロー　（下）" }
    association :user
  end
end
