class SessionsController < ApplicationController
  before_action :require_login, only: %i[destroy]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to root_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end

  def guest_login
    username = 'guest'
    email = 'guest@guest.jp'
    password = 'guestguest'
    user = User.find_by(email: email)
    if !user
      User.create(
        username: username,
        email: email,
        password: password,
        password_confirmation: password
      )
    end
    @user = login(email, password)
    if @user
      redirect_back_or_to root_path, success: 'ゲストユーザーとしてログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
end
