class QuestionsController < ApplicationController
  before_action :require_login, only: %i[new create destroy]
  layout 'book_detail'

  def index
    @questions = Question.all.includes(%i[user book]).page(params[:page]).per(10).order(created_at: :desc)
    render layout: 'application'
  end

  def random
    @question = Question.all.sample
    redirect_to @question
  end

  def show
    @question = Question.find(params[:id])
    @book = @question.book
    case @question.answer_type.to_sym
    when :choice
      @choices = @question.choices.includes([:question, question: %i[book user]]).shuffle
    when :description
      @answer_description = @question.answer_description
      render template: 'questions/quiz_description'
    end
  end

  def destroy
    @question = current_user.questions.find(params[:id])
    @question.destroy
  end
end
