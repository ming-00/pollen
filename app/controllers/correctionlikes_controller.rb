class CorrectionlikesController < ApplicationController
    protect_from_forgery with: :exception
    skip_before_action :verify_authenticity_token, :only => :create
    before_action :find_correction
    before_action :find_correctionlike, only: [:destroy]

    def create
        if already_liked?
            flash[:notice] = "You can't like more than once."
        elsif current_user == @correction.user
            flash[:notice] = "You can't like your own correction."
        else
          @correction.correctionlikes.create(user_id: current_user.id)
          Notification.create(title: @correction.entry.title, recipient: @correction.user, actor: current_user, action: "liked", notifiable: @correction)
          @correction_user = @correction.user
          @correction_user.increment!(:points)
        end
        redirect_to @correction.entry
    end

    def already_liked?
        Correctionlike.where(user_id: current_user.id, correction_id:
            params[:correction_id]).exists?
    end

    def destroy
        if !(already_liked?)
          flash[:notice] = "Cannot unlike"
        else
          @correctionlike.destroy
          @correction.user.decrement!(:points)
        end
        redirect_to @correction.entry
    end

    private

    def find_correction
        @correction = Correction.find(params[:correction_id])
    end

    def find_correctionlike
        @correctionlike = @correction.correctionlikes.find(params[:id])
    end
end
