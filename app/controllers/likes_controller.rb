class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @book = Book.find(params[:book_id])
    current_user.like(@book)
  end

  def destroy
    @book = current_user.likes.find(params[:id]).book
    current_user.unlike(@book)
  end
end
