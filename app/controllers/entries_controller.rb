class EntriesController < ApplicationController
    before_action :require_login
    before_action :correct_user,   only: [:destroy, :update, :edit]

    def new
        if current_user.journals.any?
            @entry = Entry.new
            @journ = params[:journal]
        else
            flash[:danger] = "Please create a journal first!"
            redirect_to '/profile'
        end
    end 
    
    def create
        @journal = Journal.find(params[:entry][:journal_id])
        @entry = @journal.entries.build(entry_params)
        if @entry.save
            if @entry.journal.private == false
                (@entry.journal.user.followers).each do |user|
                    Notification.create(title: @entry.title, recipient: user, actor: current_user, action: "created", notifiable: @entry)
                end
            end
            @entry.journal.user.increment!(:points)
            flash[:success] = "Entry created!"
            redirect_to @entry
        else
            flash.now[:error] = @entry.errors.full_messages[0]
            render :new
        end
    end

    def show
        @entry = Entry.find(params[:id])
        @correction = Correction.new
        @correction.entry = @entry
        @corrections = @entry.corrections
        @entry.punch(request)
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
        @journal = @entry.journal
        @entry.destroy
        @journal.user.decrement!(:points)
        flash[:success] = "Entry deleted"
        redirect_to @journal
    end

    def markresolved
        @entry = Entry.find(params[:id])
        if @entry.resolved == false
            (@entry.users.uniq - [current_user]).each do |user|
                Notification.create(title: @entry.title, recipient: user, actor: current_user, action: "resolved", notifiable: @entry)
            end
            @entry.update_attributes(resolved: true)
            flash[:success] = "Entry marked resolved and removed from journal feed!"
        else 
            @entry.update_attributes(resolved: false)
            flash[:success] = "Entry marked unresolved and added back to journal feed!"
        end
        redirect_to @entry
    end

    def correct_user
        @entry = current_user.entries.find_by(id: params[:id])
        if @entry.nil?
            flash[:danger] = "Users can only update their own entries."
            redirect_to root_url 
        end
    end

    private 
    def entry_params
        defaults = { user_id: current_user }
        params.require(:entry).permit(:title, :content, :journal_id, :user_id).reverse_merge(defaults)
    end
end
