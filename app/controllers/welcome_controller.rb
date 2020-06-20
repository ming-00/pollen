class WelcomeController < ApplicationController
  before_action :require_login

  def index
  end

  def forum
    @forumposts = current_user.forumposts.paginate(page: params[:page])
    @forumpost = current_user.forumposts.build if logged_in?
  end

  def profile
    @journals = current_user.journals.paginate(page: params[:page])
    @journal = current_user.journals.build if logged_in?
  end

end
