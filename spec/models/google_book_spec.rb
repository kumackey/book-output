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

  it '適切なキーワードから複数の検索結果を返し、そのタイトルにキーワードが含まれていること' do
    keyword = 'Ruby'
    keyword_count = 0
    google_books = GoogleBook.search(keyword)
    expect(google_books.size).to be >= 5 #  検索結果を5個以上は返せる
    google_books.each do |google_book|
      if google_book.title.include?(keyword)
        keyword_count += 1
      end
    end
    expect(keyword_count).to be >= 5 #  キーワードのRubyを含むタイトルが5個以上は返せる
  end

  it '不適切なキーワードからは検索結果を返さないこと' do
    keyword = 'bbvjnaovnaov' #  適当
    google_books = GoogleBook.search(keyword)
    expect(google_books.size).to be 0
  end

  it '適切な本情報を保存できること' do
    google_book = build(:google_book, authors: [
                          '太田 智彬',
                          '寺下 翔太',
                          '手塚 亮',
                          '宗像 亜由美',
                          '株式会社リクルートテクノロジーズ'
                        ])
    expect { google_book.save }.to change { Book.count }.by(1).and change { Author.count }.by(5)
  end

  it '適切な本情報を保存したときにtrueを返すこと' do
    expect(google_book.save).to be_truthy
  end

  it '不適切な本情報の保存に失敗すること' do
    google_book = build(:google_book, googlebooksapi_id: nil)
    expect { google_book.save }.to change { Book.count }.by(0).and change { Author.count }.by(0)
  end

  it '不適切な本情報を保存しようとしたときにfalseを返すこと' do
    google_book = build(:google_book, googlebooksapi_id: nil)
    expect(google_book.save).not_to be_truthy
  end
end
