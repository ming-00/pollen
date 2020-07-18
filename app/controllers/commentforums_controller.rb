class CommentforumsController < ApplicationController
    before_action :require_login
    before_action :correct_user,   only: [:destroy, :edit, :update]
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
        @forumpost = Forumpost.find(params[:forumpost_id])
        @commentforum = @forumpost.commentforums.find(params[:id])
        @commentforum.destroy
        flash[:success] = "Comment deleted!"
        redirect_to forumpost_path(@forumpost)
    end

    def update
        @forumpost = Forumpost.find(params[:forumpost_id])
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
        @forumpost = Forumpost.find(params[:forumpost_id])
        @commentforum = Commentforum.find(params[:id])
    end

    def markaccepted
        @commentforum = Commentforum.find(params[:id])
        @forumpost = @commentforum.forumpost
        if @commentforum.accepted == false
            @commentforum.user.increment!(:points, by = 5)
            @commentforum.update_attributes(accepted: true)
            flash[:success] = "Comment accepted as best answer!"
        else 
            @commentforum.update_attributes(accepted: false)
            @commentforum.user.decrement!(:points, by = 5)
            flash[:success] = "Correction unaccepted!"
        end
        redirect_to forumpost_path(@forumpost)
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
