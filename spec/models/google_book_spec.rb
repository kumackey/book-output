require 'rails_helper'

RSpec.describe GoogleBook, type: :model do
  let(:google_book) { build(:google_book) }

  it '有効なファクトリを持つこと' do
    expect(google_book).to be_valid
  end

  it 'Google Books APIが存在しないときに無効なこと' do
    google_book = build(:google_book, googlebooksapi_id: nil)
    google_book.valid?
    expect(google_book.errors.messages[:googlebooksapi_id]).to include('を入力してください')
  end

  it 'タイトルが存在しないときに無効なこと' do
    google_book = build(:google_book, title: nil)
    google_book.valid?
    expect(google_book.errors.messages[:title]).to include('を入力してください')
  end
end
