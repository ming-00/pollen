class JournalsController < ApplicationController
    before_action :require_login
    before_action :correct_user,   only: :destroy

    def create
        @journal = current_user.journals.build(journal_params)
        if @journal.save
            flash[:success] = "Journal created!"
            redirect_to "/profile"
        else
            flash[:danger] = @journal.errors.full_messages[0]
            redirect_to "/profile"
        end
    end

    def show
        @journal = Journal.find(params[:id])
        if current_user != (@journal.user) && @journal.private
            flash[:danger] = "Journal is private."
            redirect_to root_url
        end
    end

    def destroy
        @journal.destroy
        flash[:success] = "Journal deleted"
        redirect_to request.referrer || root_url
    end

    private
    def journal_params
      params.require(:journal).permit(:title, :private)
    end

    def correct_user
        @journal = current_user.journals.find_by(id: params[:id])
        redirect_to root_url if @journal.nil?
    end
end