# == Schema Information
#
# Table name: books
#
#  id           :bigint           not null, primary key
#  author       :string(255)      not null
#  detail       :text(65535)
#  image        :string(255)
#  isbn         :integer          not null
#  published_at :datetime
#  title        :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint
#
# Indexes
#
#  index_books_on_author   (author)
#  index_books_on_isbn     (isbn) UNIQUE
#  index_books_on_title    (title)
#  index_books_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Book, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
