class RelationshipsController < ApplicationController
    before_action :logged_in_user

    def create
        user = User.find(params[:followed_id])
        current_user.following << user
        flash[:success] = "Followed successfully!"
        Notification.create(title: "New follower", recipient: user, actor: current_user, action: "started following", notifiable: user)
        redirect_to user
    end

    def destroy
        user = Relationship.find(params[:id]).followed
        current_user.following.delete(user)
        flash[:success] = "Unfollowed successfully!"
        redirect_to user
    end

    def follow(other_user)
        following << other_user
    end
    
    def unfollow(other_user)
        following.delete(other_user)
    end
end
