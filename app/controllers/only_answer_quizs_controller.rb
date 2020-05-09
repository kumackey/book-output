class OnlyAnswerQuizsController < ApplicationController
  before_action :require_login, only: %i[new]

  def new
    @book = Book.find(params[:book_id])
    @only_answer_quiz_form = OnlyAnswerQuizForm.new
    render layout: 'book_detail'
  end
end
