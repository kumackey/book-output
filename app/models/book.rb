# == Schema Information
#
# Table name: books
#
#  id           :bigint           not null, primary key
#  author       :string(255)      not null
#  detail       :text(65535)
#  image        :string(255)
#  isbn         :bigint           not null
#  published_at :date
#  title        :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_books_on_isbn                                         (isbn) UNIQUE
#  index_books_on_user_id                                      (user_id)
#  index_books_on_user_id_and_created_at_and_author_and_title  (user_id,created_at,author,title)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Book < ApplicationRecord
  belongs_to :user
end
