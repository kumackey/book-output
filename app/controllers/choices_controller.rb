class ChoicesController < ApplicationController
  before_action :require_login, only: %i[show]

  def show
    @choice = Choice.find(params[:id])
    @choices = @choice.question.choices.includes(:question).order(:created_at)
  end
end
