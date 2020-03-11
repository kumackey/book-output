class OutputsController < ApplicationController
  before_action :require_login, only: %i[new create destroy]

  def index
    @outputs = Output.all.includes(%i[user book]).page(params[:page]).per(10).order(created_at: :desc)
  end

  def latest
    @output = Output.last
    redirect_to @output
  end

  def new
    @register_output_form = RegisterOutputForm.new
    @book = Book.find(params[:book_id])
  end

  def create
    @register_output_form = RegisterOutputForm.new(create_output_params)
    @book = Book.find(params[:book_id])
    if @register_output_form.valid?
      save_question_and_choices_from(@register_output_form, @book)
      redirect_to @book, success: '問題を作成しました'
    else
      flash.now[:danger] = '問題の作成に失敗しました'
      render :new
    end
  end

  def show
    @output = Output.find(params[:id])
    @choices = @output.choices.includes([:output, output: [:book, :user]]).shuffle
  end

  def destroy
    @output = current_user.outputs.find(params[:id])
    @output.destroy
  end

  private

  def save_question_and_choices_from(register_output_form, book)
    output = current_user.outputs.build(content: register_output_form.question)
    output.book_id = book.id
    output.save

    register_output_form.choices.each.with_index do |content, i|
      choice = output.choices.build(content: content)
      if register_output_form.answer_number == i + 1
        choice.is_answer = true
      end
      choice.save
    end
  end

  def create_output_params
    params.require(:register_output_form).permit(:question, :choice_1, :choice_2, :choice_3, :choice_4, :answer_number)
  end

  def update_output_params
    params.require(:output).permit(:content)
  end
end
