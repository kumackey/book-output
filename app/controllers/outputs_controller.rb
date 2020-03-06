class OutputsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
  end

  def create
    @output = current_user.outputs.build(create_output_params)
    book = @output.book
    if @output.save
      redirect_to book, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      book = @output.book
      redirect_to book, danger: '投稿に失敗しました'
    end
  end

  private

  def create_output_params
    params.require(:output).permit(:content).merge(book_id: params[:book_id])
  end
end
