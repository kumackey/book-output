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
    if @login_form.valid? && @user
      redirect_back_or_to home_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, success: 'ログアウトしました'
  end

  def guest_login
    authenticated
    @user = User.find_by(email: 'guest@guest.jp')
    auto_login @user
    redirect_back_or_to home_path, info: 'ゲストユーザーとしてログインしました'
  end

  private

  def login_form_params
    params.require(:login_form).permit(:email, :password)
  end
end
