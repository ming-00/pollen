class CorrectionsController < ApplicationController
    before_action :require_login
    before_action :correct_user,   only: [:destroy, :destroy, :show]

    def new
        @correction = Correction.new(entry_id: params[:entry_id])
    end

    def create
        @entry = Entry.find(params[:correction][:entry_id])
        @title = @entry.title
        @content = @entry.content.split(/\?|\.|!/)
        @user = current_user
        @correction = @entry.corrections.build(correction_params)
        @correction.user = current_user
        if @correction.save
            flash[:success] = "Correction created!"
            redirect_to @entry
        else
            flash[:danger] = @correction.errors.full_messages[0]
            redirect_to request.referrer
        end
    end

    def show
        @entry = Entry.find(params[:id])
        @corrections = @entry.corrections.paginate(page: params[:page])
    end

    def update
        @correction = Correction.find(params[:id])
        @correction.correct = false
        @correction.user = current_user
        @entry = @correction.entry
        if @correction.update(correction_params)
          flash[:success] = "Correction updated"
          redirect_to @entry
        else 
          flash[:danger] = @correction.errors.full_messages[0]
          redirect_to @entry
        end
    end

    def edit
        @correction = Correction.find(params[:id])
        @correction.user = current_user
        @correction.correct = false
    end

    def destroy
        @correction.destroy
        flash[:success] = "Correction deleted"
        redirect_to request.referrer || root_url
    end

    def correct_user
        @correction = current_user.corrections.find_by(id: params[:id])
        if @correction.nil?
            flash[:danger] = "Users can only update their own corrections."
            redirect_to root_url 
        end
    end

    private 
    def correction_params
        params.require(:correction).permit(:content, :comment, :correct, :user_id, :entry_id)
    end
end