class QuizChoicesController < ApplicationController
  before_action :require_login, only: %i[new]
  layout 'book_detail'

  def new
    @book = Book.find(params[:book_id])
    @create_quiz_choice_form = CreateQuizChoiceForm.new
  end

  def create
    @book = Book.find(params[:book_id])
    @create_quiz_choice_form = CreateQuizChoiceForm.new(create_question_params)
    if @create_quiz_choice_form.save
      redirect_to @book, success: '問題を作成しました'
    else
      flash.now[:danger] = '問題の作成に失敗しました'
      render :new
    end
  end
  
  private

  def create_question_params
    params.require(:create_quiz_choice_form)
          .permit(:question_content, :correct_choice, :incorrect_choice_1, :incorrect_choice_2, :incorrect_choice_3, :commentary)
          .merge(user_id: current_user.id, book_id: params[:book_id])
  end
end
