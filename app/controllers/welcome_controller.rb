class WelcomeController < ApplicationController
  before_action :require_login, except: [:landing]
  before_action :clear,  except: [:landing]

  def landing
    render :layout => false
  end

  def index
  end

  def forum
    @forumposts = Forumpost.all.paginate(page: params[:page])
    @forumpost = current_user.forumposts.build if logged_in?
  end

  def profile
    @journals = current_user.journals.paginate(page: params[:page])
    @journal = current_user.journals.build if logged_in?
    @entries = @journal.entries.paginate(page: params[:page])
    @entry = @journal.entries.build if logged_in?
  end

  def feed
    @entries = Entry.all.paginate(page: params[:page])
  end

  private
  def clear
    current_user.tagarray.each do |tag|
      User.update_all(['tagarray = array_remove(tagarray, ?)', tag])
    end
  end

end
