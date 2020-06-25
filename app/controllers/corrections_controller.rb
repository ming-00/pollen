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

    def destroy
    end

    private 
    def correction_params
        defaults = { user_id: current_user }
        params.require(:correction).permit(:content, :comment, :correct, :user_id, :entry_id).reverse_merge(defaults)
    end
end
