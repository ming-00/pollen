class ForumpostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :edit, :update, :search]

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
        @forumpost = Forumpost.find(params[:id])
        @forumpost.destroy
        flash[:success] = "Thread destroyed"
        redirect_to request.referrer
    end

    def update
        @forumpost = Forumpost.find(params[:id])
        if @forumpost.update(forumpost_params)
          flash[:success] = "Thread updated"
          redirect_to "Welcome/forum"
        else 
          flash[:danger] = @forumpost.errors.full_messages[0]
          redirect_to request.referrer
        end
    end

    def edit
        @forumpost = Forumpost.find(params[:id])
    end

    def search
        if params[:search].blank?
            @forumposts = Forumpost.all
        else 
            @forumposts = Forumpost.search(params)
        end
    end


    def show
        @forumposts = Forumpost.find(params[:id])
    end

    private
    def forumpost_params
        params.require(:forumpost).permit(:content, :title, :tag_list)
    end
end
