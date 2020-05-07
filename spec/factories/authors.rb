# == Schema Information
#
# Table name: authors
#
#  id                :bigint           not null, primary key
#  is_representation :boolean
#  name              :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  book_id           :bigint
#
# Indexes
#
#  index_authors_on_book_id  (book_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#

FactoryBot.define do
  factory :author do
    name { 'ダニエル・カーネマン' }
    is_representation { true }
    association :book
  end
end
