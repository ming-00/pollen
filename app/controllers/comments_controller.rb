class CommentsController < ApplicationController
    def create
        @forumpost = Forumpost.find(params[:forumpost_id])
        @comment = @forumpost.comments.create(params[:comment].permits(:body))
        redirect_to root_path
    end

    def index
    end
end
