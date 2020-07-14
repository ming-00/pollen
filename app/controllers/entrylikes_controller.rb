class EntrylikesController < ApplicationController
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token, :only => :create
    before_action :find_entry
    before_action :find_entrylike, only: [:destroy]

    def create
        if already_liked?
          flash[:notice] = "You can't like more than once"
        else
          @entry.entrylikes.create(user_id: current_user.id)
          @entry_user = @entry.journal.user
          @entry_user.increment!(:points)
        end
        redirect_to @entry
    end

    def already_liked?
        Entrylike.where(user_id: current_user.id, entry_id:
            params[:entry_id]).exists?
    end

    def destroy
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @entrylike.destroy
          @entry.journal.user.decrement!(:points)
        end
        redirect_to @entry
    end

    private

    def find_entry
        @entry = Entry.find(params[:entry_id])
    end

    def find_entrylike
        @entrylike = @entry.entrylikes.find(params[:id])
    end
end
