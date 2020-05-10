class AnswerDescriptionsController < ApplicationController
  layout 'book_detail'

  def show
    @answer_description = AnswerDescription.find(params[:id])
    @question = @answer_description.question
    return unless @question.description?

    @book = @question.book
  end
end
