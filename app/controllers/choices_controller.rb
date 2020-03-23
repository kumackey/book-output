class ChoicesController < ApplicationController
  def show
    @choice = Choice.find(params[:id])
    @choices = @choice.question.choices.includes(:question).order(:created_at)
  end
end
