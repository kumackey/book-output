require 'rails_helper'

RSpec.describe "Likes", type: :request do
  it '本にいいねができること' do
    login
    book = create(:book)
    expect { post '/likes', params: { book_id: book.id }, xhr: true }.to change{ Like.count }.by(1)
  end

  it '本のいいねを削除できること' do
    user = login
    book = create(:book)
    user.like(book)
    like = Like.find_by(user_id: user.id, book_id: book.id)
    expect { delete "/likes/#{like.id}", xhr: true }.to change{ Like.count }.by(-1)
  end
end

