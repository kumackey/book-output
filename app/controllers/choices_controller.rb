class ChoicesController < ApplicationController
  layout 'book_detail'

  def show
    @choice = Choice.find(params[:id])
    @question = @choice.question
    return unless @question.choice?

    @book = @question.book
    @choices = @question.choices.includes(:question).order(:created_at)
  end
end
