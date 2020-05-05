require 'rails_helper'

RSpec.describe "Likes", type: :request do
  it '本にいいねができること' do
    login
    book = GoogleBook.new_from_id("4j13KIu3Z60C")
    expect { post '/likes', params: { book_id: book.googlebooksapi_id }, xhr: true }.to change{ Like.count }.by(1)
  end

  it '本のいいねを削除できること' do
    user = login
    book = GoogleBook.new_from_id("4j13KIu3Z60C")
    user.like_google_book(book)
    like = Like.find_by(user_id: user.id, book_id: book.googlebooksapi_id)
    expect { delete "/likes/#{like.id}", xhr: true }.to change{ Like.count }.by(-1)
  end
end

