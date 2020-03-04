# == Schema Information
#
# Table name: books
#
#  id                :bigint           not null, primary key
#  author            :string(255)      not null
#  buy_link          :string(255)
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

    after :create do |book|
      book.update_column(:image, "images/fast_and_slow.jpeg")
    end

    published_at { "2013-05-24" }
    title { "ファスト＆スロー(下)" }
    googlebooksapi_id { "yHrxYFWkrfQC" }
    buy_link { "https://play.google.com/store/books/details?id=yHrxYFWkrfQC&rdid=book-yHrxYFWkrfQC&rdot=1&source=gbs_api" }
    association :user
  end

  factory :other_book, class: Book do
    author  { "ロバート・B. チャルディーニ" }
    description { "著者は、セールスマン、募金勧誘者、広告主など承諾誘導のプロの世界に潜入。彼らのテクニックや方略から「承諾」についての人間心理のメカニズムを解明。情報の氾濫する現代生活で、だまされない賢い消費者になると共に、プロの手口から人を説得するやり方を学ぶ。" }

    after :create do |book|
      book.update_column(:image, "images/Influence.jpeg")
    end

    published_at { "2007-08" }
    title { "影響力の武器" }
    googlebooksapi_id { "axicQgAACAAJ" }
    buy_link { "" }
    association :user
  end
end
