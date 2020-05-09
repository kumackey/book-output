class OnlyAnswerQuizsController < ApplicationController
  before_action :require_login, only: %i[new]

  def new
    @book = Book.find(params[:book_id])
    @only_answer_quiz_form = OnlyAnswerQuizForm.new
    render layout: 'book_detail'
  end

  def create
    @book = Book.find(params[:book_id])
    @only_answer_quiz_form = OnlyAnswerQuizForm.new(create_question_params)
    if @only_answer_quiz_form.save
      redirect_to @book, success: '問題を作成しました'
    else
      flash.now[:danger] = '問題の作成に失敗しました'
      render layout: 'book_detail', action: :new
    end
  end

  private

  def create_question_params
    params.require(:only_answer_quiz_form)
          .permit(:question_content, :answer_content, :commentary)
          .merge(user_id: current_user.id, book_id: params[:book_id])
  end
end
