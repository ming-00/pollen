class ForumpostlikesController < ApplicationController
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token, :only => :create
    before_action :find_forumpost
    before_action :find_forumpostlike, only: [:destroy]


    def create
        if already_liked?
          flash[:notice] = "You can't like more than once"
        else
          @forumpost.forumpostlikes.create(user_id: current_user.id)
        end
        redirect_to forumpost_path(@forumpost)
    end

    def already_liked?
        Forumpostlike.where(user_id: current_user.id, forumpost_id:
        params[:forumpost_id]).exists?
    end

    def destroy
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @forumpostlike.destroy
        end
        redirect_to forumpost_path(@forumpost)
    end

    private

    def find_forumpost
        @forumpost = Forumpost.find(params[:forumpost_id])
    end

    def find_forumpostlike
        @forumpostlike = @forumpost.forumpostlikes.find(params[:id])
     end

end
