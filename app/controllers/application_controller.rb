class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session
  include Clearance::Controller
  def logged_in? 
    !current_user.nil? 
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  def following?(other_user)
    current_user.following.include?(other_user)
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
