class ChoicesController < ApplicationController
  def show
    @choice = Choice.find(params[:id])
    if @choice.question.answer_type == 'choices'
      @book = @choice.question.book
      @choices = @choice.question.choices.includes(:question).order(:created_at)
      render layout: 'book_detail'
    end
  end
end
