require 'rails_helper'

RSpec.describe "Likes", type: :request do
  it '本にいいねができること' do
    login
    book = create(:book)
    expect { post '/likes', params: { book_id: book.id }, xhr: true }.to change{ Like.count }.by(1)
  end
end

