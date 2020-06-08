class WelcomeController < ApplicationController
  before_action :require_login

  def index
  end

  def forum
  end

  # no routes here
  def profile
  end

  def feed
  end
end
