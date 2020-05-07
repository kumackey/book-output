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

require 'rails_helper'

RSpec.describe Author, type: :model do
  let(:author) { build(:author) }

  it '有効なファクトリを持つこと' do
    expect(author).to be_valid
  end

  it '著者名が空白であるときに無効なこと' do
    author = build(:author, name: nil)
    author.valid?
    expect(author.errors.messages[:name]).to include('を入力してください')
  end

  describe '著者名の文字数が' do
    context '255文字数のときに' do
      let(:author) { build(:author, name: 'a' * 255) }
      it '有効なこと' do
        expect(author).to be_valid
      end
    end
    context '256文字のときに' do
      let(:author) { build(:author, name: 'a' * 256) }
      it '無効なこと' do
        author.valid?
        expect(author.errors[:name]).to include('は255文字以内で入力してください')
      end
    end
  end
end
