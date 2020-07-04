class CommentforumsController < ApplicationController
    before_action :find_forumpost
    before_action :find_commentforum, only: [:destroy, :edit, :update]
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
            redirect_to request.referrer
        end
    end

    def destroy
        @commentforum.destroy
        flash[:success] = "Comment deleted!"
        redirect_to forumpost_path(@forumpost)
    end

    def update
        @commentforum = Commentforum.find(params[:id])
        if @commentforum.update(commentforum_params)
          flash[:success] = "Comment updated!"
          redirect_to @forumpost
        else 
          flash[:danger] = @commentforum.errors.full_messages[0]
          redirect_to request.referrer
        end
    end

    def edit
        @commentforum = Commentforum.find(params[:id])
    end

    private

    def find_forumpost
        @forumpost = Forumpost.find(params[:forumpost_id])
    end

    def find_commentforum
        @commentforum = @forumpost.commentforums.find(params[:id])
    end

    def commentforum_params
        params.require(:commentforum).permit(:reply)
    end
end
