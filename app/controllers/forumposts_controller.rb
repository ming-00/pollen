class ForumpostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]

    def create
        @forumpost = current_user.forumposts.build(forumpost_params)
        if @forumpost.save
            flash[:success] = "Post created and published in forum!"
            redirect_to "/forum"
        else
            flash[:danger] = @forumpost.errors.full_messages[0]
            render "welcome/forum"
        end
    end
    
    def destroy
    end

    def show
        @forumposts = Forumpost.find(params[:id])
    end

    private
    def forumpost_params
        params.require(:forumpost).permit(:content, :title, :tag_list)
    end
end
