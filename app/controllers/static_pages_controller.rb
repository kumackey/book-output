class StaticPagesController < ApplicationController
  def home
    @outputs = Output.all.includes(%i[user book]).page(params[:page]).per(15).order(created_at: :desc)
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end
end
