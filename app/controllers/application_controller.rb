class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def check_authentication
    if !current_user
      flash.alert = "You must be logged in!"
      redirect_to new_session_path
    end
  end
end
