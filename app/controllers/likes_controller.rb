class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @book = current_user.books.find(params[:book_id])
    current_user.like(@book)
  end
end
