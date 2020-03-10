class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end

  def authenticated
    redirect_to home_path, info: '既にログインしています' if logged_in?
  end
end
