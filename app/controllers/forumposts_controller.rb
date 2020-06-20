class ForumpostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    def create
        @forumpost = current_user.forumposts.build(forumpost_params)
        if @forumpost.save
            flash[:success] = "Post created and published in forum!"
            redirect_to root_url
        else
            render 'welcome/home'
        end
    end
    
    def destroy
    end

    private
    def micropost_params
        params.require(:forumpost).permit(:content)
    end
end
