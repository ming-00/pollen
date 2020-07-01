class CommentforumsController < ApplicationController
    before_action :find_forumpost
    def create
        @forumpost = Forumpost.find(params[:forumpost_id])
        @commentforum = @forumpost.commentforums.create(params[:commentforum].permit(:reply))
        @commentforum.user_id = current_user.id
        @commentforum.save

        if @commentforum.save
            flash[:success] = "Comment created!"
            redirect_to forumpost_path(@forumpost)
        else
            flash[:danger] = "Comment creation failed."
            render 'new'
        end
    end

    private

    def find_forumpost
        @forumpost = Forumpost.find(params[:forumpost_id])
    end
end
