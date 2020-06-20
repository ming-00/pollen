class ApplicationController < ActionController::Base
  include Clearance::Controller
  def logged_in? 
    !current_user.nil? 
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to "/sign_in"
    end
  end
end
