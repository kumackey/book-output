class StaticPagesController < ApplicationController
  before_action :require_login, only: %i[home]

  def home
    # ログイン時のトップページ
    @questions = current_user.feed.includes(%i[user book]).page(params[:page]).per(10).order(created_at: :desc)
    @books = Book.includes(:user).order(created_at: :desc).limit(5)
  end

  def top
    authenticated
    @questions = Question.all.includes(%i[user book]).order(created_at: :desc).limit(5)
    @books = Book.all.includes(:user).order(created_at: :desc).limit(3)
  end

  def contact; end
end
