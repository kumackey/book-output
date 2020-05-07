require 'rails_helper'

RSpec.describe GoogleBook, type: :model do
  let(:google_book) { build(:google_book) }

  it '有効なファクトリを持つこと' do
    expect(google_book).to be_valid
  end

  it 'Google Books APIのIDが存在しないときに無効なこと' do
    google_book = build(:google_book, googlebooksapi_id: nil)
    google_book.valid?
    expect(google_book.errors.messages[:googlebooksapi_id]).to include('を入力してください')
  end

  it 'タイトルが存在しないときに無効なこと' do
    google_book = build(:google_book, title: nil)
    google_book.valid?
    expect(google_book.errors.messages[:title]).to include('を入力してください')
  end

  it 'Google Books APIのIDから目的のインスタンスを生成できること' do
    googlebooksapi_id = 'YEfUBgAAQBAJ'
    google_book = GoogleBook.new_from_id(googlebooksapi_id)
    expect(google_book.title).to eq 'SpriteKitではじめる2Dゲームプログラミング Swift対応'
    expect(google_book.googlebooksapi_id).to eq googlebooksapi_id
    expect(google_book.authors).to eq %w[山下佳隆 村田知常 原知愛 近藤秀彦]
    expect(google_book.author).to eq '山下佳隆'
  end
end
