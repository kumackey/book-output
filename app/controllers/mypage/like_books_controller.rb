class Mypage::LikeBooksController < Mypage::BaseController
  def index
    @user = User.find(current_user.id)
    @books = @user.like_books.order(created_at: :desc)
  end
end
