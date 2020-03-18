class Mypage::AccountsController < Mypage::BaseController
  def show
    @user = User.find(current_user.id)
    @books = @user.like_books.includes(:user).order(created_at: :desc)
    respond_to do |format|
      format.html do
        @questions = @user.questions.includes(%i[user book]).page(params[:page]).per(10).order(created_at: :desc)
      end
      format.csv do
        @questions = @user.questions.includes(%i[user book]).order(created_at: :desc)
      end
    end
  end
end