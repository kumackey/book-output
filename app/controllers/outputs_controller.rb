class OutputsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
  end

  def create
    @output = current_user.outputs.create(create_output_params)
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
    params.require(:output).permit(:content).merge(book_id: params[:book_id])
  end

  def update_output_params
    params.require(:output).permit(:content)
  end
end
