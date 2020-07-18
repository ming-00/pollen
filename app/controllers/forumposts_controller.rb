class ForumpostsController < ApplicationController
    before_action :require_login
    before_action :logged_in_user, only: [:create, :destroy, :edit, :update, :search]

    def new
        @forumpost = Forumpost.new
    end 
    
    def create
        @forumpost = current_user.forumposts.build(forumpost_params)
        if @forumpost.save
            flash[:success] = "Post created and published in forum!"
            @forumpost.user.increment!(:points)
            redirect_to "/forum"
        else
            flash[:danger] = "Please fill in title and content."
            redirect_to '/forum'
        end
    end

    
    def destroy
        @forumpost = Forumpost.find(params[:id])
        @forumpost.destroy
        @forumpost.user.decrement!(:points)
        flash[:success] = "Thread deleted!"
        redirect_to request.referrer
    end

    def update
        @forumpost = Forumpost.find(params[:id])
        if @forumpost.update(forumpost_params)
          flash[:success] = "Thread updated!"
          redirect_to @forumpost
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
        @forumposts.punch(request)
    end

    def tag_cloud
        @tags = Forumpost.tag_counts_on(:tags)
      end

    def markaccepted
        @forumpost = Forumpost.find(params[:id])
        if @forumpost.accepted == false
            @forumpost.update_attributes(accepted: true)
        else 
            @forumpost.update_attributes(accepted: false)
        end
        redirect_to request.referrer
    end


    private
    def forumpost_params
        params.require(:forumpost).permit(:content, :title, :tag_list => [])
    end
end
