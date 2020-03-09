class SessionsController < ApplicationController
  before_action :require_login, only: %i[destroy]

  def new
    authenticated
    @login_form = LoginForm.new
  end

  def create
    authenticated
    @login_form = LoginForm.new(login_form_params)
    @user = login(@login_form.email, @login_form.password)
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
    unless user
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

  private

  def login_form_params
    params.require(:login_form).permit(:email, :password)
  end
end
