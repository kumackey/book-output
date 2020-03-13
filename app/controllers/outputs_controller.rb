class OutputsController < ApplicationController
  before_action :require_login, only: %i[new create destroy]

  def index
    @outputs = Output.all.includes(%i[user book]).page(params[:page]).per(10).order(created_at: :desc)
  end

  def random
    @output = Output.all.sample
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
      @register_output_form.save_from_user_and_book(current_user, @book)
      redirect_to @book, success: '問題を作成しました'
    else
      flash.now[:danger] = '問題の作成に失敗しました'
      render :new
    end
  end

  def show
    @output = Output.find(params[:id])
    @choices = @output.choices.includes([:output, output: %i[book user]]).shuffle
  end

  def destroy
    @output = current_user.outputs.find(params[:id])
    @output.destroy
  end

  private

  def create_output_params
    params.require(:register_output_form).permit(:question, :correct_choice, :incorrect_choice_1, :incorrect_choice_2, :incorrect_choice_3)
  end

  def update_output_params
    params.require(:output).permit(:content)
  end
end
