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

require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { build(:author) }

  it "有効なファクトリを持つこと" do
    expect(author).to be_valid
  end
end
