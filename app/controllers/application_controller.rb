class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private

  def ensure_sign_in
    redirect_to root_path unless logged_in?
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

end
