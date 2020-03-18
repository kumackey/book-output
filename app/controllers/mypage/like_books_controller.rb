class Mypage::LikeBooksController < Mypage::BaseController
  def show
    @user = User.find(current_user.id)
    @books = @user.like_books.includes(:user).order(created_at: :desc)
  end
end
