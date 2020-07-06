ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  require "clearance/test_unit"

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  def manual_sign_in_as(user)
    post session_url, params: {
      session: {
        email: user.email,
        password: user.password
      }
    }
  end

  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end