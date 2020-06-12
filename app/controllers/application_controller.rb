class ApplicationController < ActionController::Base
  include Clearance::Controller
  def logged_in? 
    !current_user.nil? 
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
end
