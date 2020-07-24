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
            @commentforum.user.increment!(:points)
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
        @commentforum.user.decrement!(:points)
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
            @commentforum.user.increment!(:points, by = 5) unless @commentforum.user == @forumpost.user
            @commentforum.update_attributes(acceptedscore: true)
            @commentforum.update_attributes(accepted: true)
            @commentforum.increment!(:acceptedscore, by = 10)
            flash[:success] = "Comment accepted as best answer and thread is resolved!"
            @commentforum.forumpost.update_attributes(accepted: true)
        else 
            @commentforum.update_attributes(accepted: false)
            @commentforum.decrement!(:acceptedscore, by = 10)
            @commentforum.user.decrement!(:points, by = 5) unless @commentforum.user == @forumpost.user
            flash[:success] = "Correction unaccepted!"
            @commentforum.forumpost.update_attributes(accepted: false)
        end
        redirect_to forumpost_path(@forumpost)
    end

    def correct_user
        @commentforum = current_user.commentforums.find_by(id: params[:id])
        if @commentforum.nil?
            flash[:danger] = "Users can only update their own threads."
            redirect_to root_url 
        end
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
