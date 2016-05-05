class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :save_current_url

  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = 'You are unauthorized!'
    if logged_in?
      redirect_to session.delete(:return_to)
    else
      redirect_to :login
    end
  end

  private

  def save_current_url
    session[:return_to] = request.referer
  end

end
