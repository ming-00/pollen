class WelcomeController < ApplicationController
  before_action :require_login

  def index
  end

  def forum
  end

  def profile
    @journals = current_user.journals.paginate(page: params[:page])
    @journal = current_user.journals.build if logged_in?
  end

end
