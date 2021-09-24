class ApplicationController < ActionController::Base
  helper_method :current_user, :logeed_in?
=begin 
  def current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end

=end
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logeed_in?
    !!current_user
  end

end
