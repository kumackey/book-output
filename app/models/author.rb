# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  book_id    :bigint
#
# Indexes
#
#  index_authors_on_book_id  (book_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#

class Author < ApplicationRecord
  belongs_to :book

  validates :name, presence: true, length: { maximum: 255 }
end
