class UsersController < ApplicationController
  def new
    authenticated
    @user = User.new
  end

  def create
    authenticated
    @user = User.new(user_params)
    if @user.save
      auto_login @user
      redirect_to home_path, success: 'ユーザーを作成し、ログインしました'
    else
      flash.now[:danger] = 'ユーザーの作成に失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.includes(:user, :book).page(params[:page]).per(10).order(created_at: :desc)
    @books = @user.like_books.includes(:user).order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username)
  end
end
