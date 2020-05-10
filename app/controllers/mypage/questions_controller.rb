class Mypage::QuestionsController < Mypage::BaseController
  def index
    @user = User.find(current_user.id)
    respond_to do |format|
      format.html do
        @questions = @user.questions.includes(%i[user book]).page(params[:page]).per(10).order(created_at: :desc)
      end
      format.csv do
        @questions = @user.questions.includes(%i[user book]).order(created_at: :desc)
      end
    end
  end
end
