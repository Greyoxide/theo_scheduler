class ApplicationController < ActionController::Base

  before_action :capture_path, if: :current_user

  def current_user
    @current_user ||= User.find_by_secure_token(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end
end
