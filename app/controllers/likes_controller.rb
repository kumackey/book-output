class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @book = GoogleBook.new_from_id(params[:book_id])
    current_user.like_google_book(@book)
  end

  def destroy
    @book = current_user.likes.find(params[:id]).google_book
    current_user.unlike_google_book(@book)
  end
end
