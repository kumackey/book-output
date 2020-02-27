class SessionsController < ApplicationController
  def new; end

  def create
    @user = login params[:email], params[:password]
    if @user
      redirect_back_or_to root_path, success: 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
end