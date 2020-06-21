class EntriesController < ApplicationController
    before_action :require_login
    before_action :correct_user,   only: [:destroy, :update, :edit]

    def create
        @journal = Journal.find(params[:entry][:journal_id])
        @entry = @journal.entries.build(entry_params)
        if @entry.save
            flash[:success] = "Entry created!"
            redirect_to request.referrer
        else
            flash[:danger] = @entry.errors.full_messages[0]
            redirect_to request.referrer
        end
    end

    def show
        @entry = Entry.find(params[:id])
        if current_user != (@entry.journal.user) && @entry.journal.private
            flash[:danger] = "Entry is private."
            redirect_to root_url
        end
    end

    def update
        @entry = Entry.find(params[:id])
        if @entry.update(entry_params)
          flash[:success] = "Entry updated"
          redirect_to @entry
        else 
          flash[:danger] = @entry.errors.full_messages[0]
          redirect_to request.referrer
        end
    end

    def edit
        @entry = Entry.find(params[:id])
    end
  
    def destroy
        @entry.destroy
        flash[:success] = "Entry deleted"
        redirect_to request.referrer || root_url
    end

    def correct_user
        @entry = current_user.entries.find_by(id: params[:id])
        flash[:danger] = "Users can only update their own entries."
        redirect_to root_url if @entry.nil?
    end

    private 
    def entry_params
        defaults = { user_id: current_user }
        params.require(:entry).permit(:title, :content, :journal_id, :user_id).reverse_merge(defaults)
    end
end
