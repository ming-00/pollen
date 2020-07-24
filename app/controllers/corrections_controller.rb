class CorrectionsController < ApplicationController
    before_action :require_login
    before_action :correct_user,   only: [:destroy, :destroy, :show]

    def new
        @correction = Correction.new(entry_id: params[:entry_id])
    end

    def create
        @entry = Entry.find(params[:correction][:entry_id])
        @title = @entry.title
        @user = current_user
        @correction = @entry.corrections.build(correction_params)
        @correction.user = current_user
        if @correction.save
            # Create notifications, change the each do loop accordingly with common sense :) rmb to 
            # update forumpost model for this to work, look at entry.rb for example if you havent alr
            (@entry.users.uniq - [current_user]).each do |user|
                Notification.create(title: @title, recipient: user, actor: current_user, action: "provided", notifiable: @correction)
            end
            # This part you do not need to do if the creator of the forumpost shows up on forumpost.users -> check with rails console or ask me if not sure
            Notification.create(title: @title, recipient: @entry.journal.user, actor: current_user, action: "provided", notifiable: @correction)

            @correction.user.increment!(:points)
            flash[:success] = "Correction created!"
            redirect_to @entry
        else
            flash[:danger] = @correction.errors.full_messages[0]
            redirect_to request.referrer
        end
    end

    def show
        @entry = Entry.find(params[:id])
        @original = @entry.content
        @corrections = @entry.corrections.paginate(page: params[:page])
    end

    def update
        @correction = Correction.find(params[:id])
        @correction.correct = false
        @correction.user = current_user
        @entry = @correction.entry
        if @correction.update(correction_params)
            (@entry.users.uniq - [current_user]).each do |user|
                Notification.create(title: @entry.title, recipient: user, actor: current_user, action: "updated", notifiable: @correction)
            end
            Notification.create(title: @entry.title, recipient: @entry.journal.user, actor: current_user, action: "updated", notifiable: @correction)
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
        @correction.user.decrement!(:points)
        flash[:success] = "Correction deleted"
        redirect_to request.referrer || root_url
    end

    def markaccepted
        @correction = Correction.find(params[:id])
        if @correction.accepted == false
            @correction.user.increment!(:points, by = 5)
            # Create notifications
            Notification.create(title: @correction.entry.title, recipient: @correction.user, actor: current_user, action: "accepted", notifiable: @correction)
            @correction.update_attributes(accepted: true)
            flash[:success] = "Correction accepted!"
        else 
            @correction.user.decrement!(:points, by = 5)
            @correction.update_attributes(accepted: false)
            flash[:success] = "Correction unaccepted!"
        end
        redirect_to request.referrer
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