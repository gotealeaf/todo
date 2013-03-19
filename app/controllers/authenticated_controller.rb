class AuthenticatedController < ApplicationController
  before_filter :ensure_sign_in

  def ensure_sign_in
    redirect_to root_path unless logged_in?
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  helper_method :current_user

end
