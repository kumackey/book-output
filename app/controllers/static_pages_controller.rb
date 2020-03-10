class StaticPagesController < ApplicationController
  before_action :require_login, only: %i[home]

  def home
    # ログイン時のトップページ
    @outputs = Output.all.includes(%i[user book]).page(params[:page]).per(15).order(created_at: :desc)
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end

  def top
    if logged_in?
      redirect_to home_path
    else
      @outputs = Output.all.includes(%i[user book]).page(params[:page]).per(15).order(created_at: :desc)
      @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
    end
  end
end
