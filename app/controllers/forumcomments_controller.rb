class ForumcommentsController < ApplicationController
    def create
		@forumpost = Forumpost.find(params[:id])
		@forumcomment = @forumpost.forumcomments.create(params[:reply].permit(:reply))
		@forumcomment.user_id = current_user.id if current_user
		@forumcomment.save

		if @forumcomment.save
			redirect_to forumpost_path(@forumpost)
		else
			render 'new'
		end
    end


	def edit
		@forumpost = Forumpost.find(params[:id])
		@forumcomment = @forumpost.forumcomments.find(params[:id])
	end

	def update
		@forumpost = Forumpost.find(params[:id])
		@forumcomment = @forumpost.forumcomments.find(params[:id])

		if @forumcomment.update(params[:reply].permit(:reply))
			redirect_to forumpost_path(@forumpost)
		else
			render 'edit'
		end
	end

	def destroy
        @forumpost = Forumpost.find(params[:id])
		@forumcomment = @forumpost.forumcomments.find(params[:id])
		@forumcomment.destroy
		redirect_to forumpost_path(@forumpost)
	end
end
