# == Schema Information
#
# Table name: questions
#
#  id          :bigint           not null, primary key
#  answer_type :integer          not null
#  commentary  :text(65535)
#  content     :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  book_id     :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_questions_on_book_id  (book_id)
#  index_questions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :question do
    content { 'これは問題文です' }
    commentary { 'これは問題文の解説です。' }
    answer_type { 0 }
    association :book
    association :user
  end

  factory :only_answer_quiz, class: Question do
    content { 'これは問題文です' }
    commentary { 'これは問題文の解説です。' }
    answer_type { 1 }
    association :book
    association :user
  end
end
