class OutputsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def new
    @register_output_form = RegisterOutputForm.new
    @book = Book.find(params[:book_id])
  end

  def create
    @register_output_form = RegisterOutputForm.new(create_output_params)
    if @register_output_form.valid?
      @output = current_user.outputs.build(content: @register_output_form.question)
      @book = Book.find(params[:book_id])
      @output.book_id = @book.id
      @output.save
      @choice_1 = @output.choices.build(content: @register_output_form.choice_1)
      @choice_2 = @output.choices.build(content: @register_output_form.choice_2)
      @choice_3 = @output.choices.build(content: @register_output_form.choice_3)
      @choice_4 = @output.choices.build(content: @register_output_form.choice_4)
      case @register_output_form.answer_number
        when 1 then
          @choice_1.is_answer = true
        when 2 then
          @choice_2.is_answer = true
        when 3 then
          @choice_3.is_answer = true
        when 4 then
          @choice_4.is_answer = true
      end
      @choice_1.save
      @choice_2.save
      @choice_3.save
      @choice_4.save
      redirect_to @book , success: '問題を作成しました'
    else
      flash.now[:danger] = '問題の作成に失敗しました'
      render :new
    end
  end

  def edit
    @output = current_user.outputs.find(params[:id])
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

  def create_output_params
    params.require(:register_output_form).permit(:question, :choice_1, :choice_2, :choice_3, :choice_4, :answer_number)
  end

  def update_output_params
    params.require(:output).permit(:content)
  end
end
