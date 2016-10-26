class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user
    redirect_to new_session_path, alert: 'Please sign in' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
  #adding this line makes this method accessible in view files. Because this
  # method is in the ApplicationController then it's accessible to all views
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id])
  end
  helper_method :current_user

end
