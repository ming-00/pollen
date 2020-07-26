class CommentforumlikesController < ApplicationController
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token, :only => :create
    before_action :find_commentforum
    before_action :find_commentforumlike, only: [:destroy]

    def create
        @forumpost = Forumpost.find(params[:forumpost_id])
        if already_liked?
            flash[:notice] = "You can't like more than once"
        else
            Notification.create(title: @commentforum.forumpost.title, recipient: @commentforum.user, actor: current_user, action: "liked", notifiable: @commentforum)
            @commentforum.commentforumlikes.create(user_id: current_user.id)
        end
        redirect_to forumpost_path(@forumpost)
    end

    def already_liked?
        Commentforumlike.where(user_id: current_user.id, commentforum_id:
        params[:commentforum_id]).exists?
    end

    def destroy
        @forumpost = Forumpost.find(params[:forumpost_id])
        if !(already_liked?)
            flash[:notice] = "Cannot unlike"
        else
            @commentforumlike.destroy
        end
        redirect_to forumpost_path(@forumpost)
    end

    private

    def find_commentforum
        @commentforum = Commentforum.find(params[:commentforum_id])
    end

    def find_commentforumlike
        @commentforumlike = @commentforum.commentforumlikes.find(params[:id])
    end
    
end
