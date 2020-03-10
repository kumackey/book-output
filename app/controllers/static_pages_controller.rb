class StaticPagesController < ApplicationController
  before_action :require_login, only: %i[home]

  def home
    # ログイン時のトップページ
    @outputs = current_user.feed.includes(%i[user book]).order(created_at: :desc).page(params[:page]).per(10).order(created_at: :desc)
    @books = current_user.like_books.includes(:user).page(params[:page])
  end

  def top
    authenticated
    @outputs = Output.all.includes(%i[user book]).page(params[:page]).per(6).order(created_at: :desc)
    @books = Book.all.includes(:user).page(params[:page]).per(6).order(created_at: :desc)
  end
end
