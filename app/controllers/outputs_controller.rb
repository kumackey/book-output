class OutputsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def new
    @register_output_form = RegisterOutputForm.new
    @book = Book.find(params[:book_id])
  end

  def create
    @register_output_form = RegisterOutputForm.new(create_output_params)
    if @register_output_form.valid?
      @book = Book.find(params[:book_id])
      save_question_and_choices_from(@register_output_form, @book)
      redirect_to @book, success: '問題を作成しました'
    else
      flash.now[:danger] = '問題の作成に失敗しました'
      render :new
    end
  end

  def edit
    @output = current_user.outputs.find(params[:id])
  end

  def show
    @output = Output.find(params[:id])
    @choices = @output.choices.all
  end

  def update
    @output = current_user.outputs.find(params[:id])
    @output.update(update_output_params)
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
