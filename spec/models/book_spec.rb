# == Schema Information
#
# Table name: books
#
#  id                :bigint           not null, primary key
#  author            :string(255)
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

require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { build(:book) }

  it "有効なファクトリを持つこと" do
    expect(book).to be_valid
  end

  it "タイトルが空白であるときに無効なこと" do
    book.title = ''
    book.valid?
    expect(book.errors.messages[:title]).to include("を入力してください")
  end

  it "Google Books APIのIDが空白であるときに無効なこと" do
    book.googlebooksapi_id = ''
    book.valid?
    expect(book.errors.messages[:googlebooksapi_id]).to include("を入力してください")
  end

  it "Google Books APIのIDが空白であるときに無効なこと" do
    create(:book, googlebooksapi_id: "yHrxYFWkrfQC")
    book = build(:other_book, googlebooksapi_id: "yHrxYFWkrfQC")
    book.valid?
    expect(book.errors[:googlebooksapi_id]).to include("はすでに存在します")
  end

  it "本が消去されたとき、関連するクイズも消えること" do
    book = create(:book)
    create(:question, book_id: book.id)
    expect{ book.destroy }.to change{ Question.count }.by(-1)
  end
end
