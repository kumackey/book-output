class QuestionsController < ApplicationController
  before_action :require_login, only: %i[new create destroy]

  def index
    @questions = Question.all.includes(%i[user book]).page(params[:page]).per(10).order(created_at: :desc)
  end

  def random
    @question = Question.all.sample
    redirect_to @question
  end

  def new
    @book = Book.find(params[:book_id])
    @register_output_form = RegisterOutputForm.new
  end

  def create
    @book = Book.find(params[:book_id])
    @register_output_form = RegisterOutputForm.new(create_question_params
      .merge(user_id: current_user.id, book_id: @book.id))
    if @register_output_form.valid?
      @register_output_form.save_question_and_choices
      redirect_to @book, success: '問題を作成しました'
    else
      flash.now[:danger] = '問題の作成に失敗しました'
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @choices = @question.choices.includes([:question, question: %i[book user]]).shuffle
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy
  end

  private

  def create_question_params
    params.require(:register_output_form)
          .permit(:question_content, :correct_choice, :incorrect_choice_1, :incorrect_choice_2, :incorrect_choice_3, :commentary)
  end
end
