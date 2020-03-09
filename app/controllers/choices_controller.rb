class ChoicesController < ApplicationController
  def check
    @choice = Choice.find(params[:id])
    @output = @choice.output
    @book = @output.book
    if @choice.is_answer.present?
      redirect_to @book, success: '正解です！'
    else
      redirect_to @output, danger: '残念！不正解です・・・'
    end
  end
end
