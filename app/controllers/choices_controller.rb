class ChoicesController < ApplicationController
  layout 'book_detail'
  
  def show
    @choice = Choice.find(params[:id])
    return unless @choice.question.choice?

    @book = @choice.question.book
    @choices = @choice.question.choices.includes(:question).order(:created_at)
  end
end
