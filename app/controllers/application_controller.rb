class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  rescue_from SecurityError do |_exception|
    redirect_to root_path, danger: '管理者画面へのアクセス権限がありません'
  end

  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end

  def authenticated
    redirect_to home_path if logged_in?
  end

  protected

  def authenticate_admin_user!
    raise SecurityError unless current_user.try(:admin?)
  end
end
