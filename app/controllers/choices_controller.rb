class ChoicesController < ApplicationController
  def show
    @choice = Choice.find(params[:id])
    @book = @choice.question.book
    @choices = @choice.question.choices.includes(:question).order(:created_at)
    render layout: 'book_detail'
  end
end
