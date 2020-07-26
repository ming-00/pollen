class ForumpostsController < ApplicationController
    before_action :require_login
    before_action :logged_in_user, only: [:create, :destroy, :edit, :update, :search]

    def new
        @forumpost = Forumpost.new
    end 
    
    def create
        @forumpost = current_user.forumposts.build(forumpost_params)
        if @forumpost.save
            @title = @forumpost.title
            flash[:success] = "Thread created and published in forum!"
            (@forumpost.user.followers.uniq).each do |user|
                Notification.create(title: @title, recipient: user, actor: current_user, action: "created ", notifiable: @forumpost)
            end
            @forumpost.update_attributes(forumpostlangid: @forumpost.user.temp_id)
            @forumpost.user.increment!(:points)
            @forumpost.tag_list.add("unresolved")
            @forumpost.save
            redirect_to "/forum"
        else
            flash[:danger] = "Please fill in title and content."
            redirect_to '/forum'
        end
    end

    
    def destroy
        @forumpost = Forumpost.find(params[:id])
        @forumpost.destroy
        @forumpost.user.decrement!(:points)
        flash[:success] = "Thread deleted!"
        redirect_to request.referrer
    end

    def update
        @forumpost = Forumpost.find(params[:id])
        @forumpost.tag_list.add("unresolved")
        @forumpost.save
        if @forumpost.update(forumpost_params)
          flash[:success] = "Thread updated!"
          redirect_to @forumpost
        else 
          flash[:danger] = @forumpost.errors.full_messages[0]
          redirect_to request.referrer
        end
    end

    def edit
        @forumpost = Forumpost.find(params[:id])
        @forumpost.tag_list.add("unresolved")
        @forumpost.save

    end

    def search
        if params[:search].blank?
            @forumposts = Forumpost.all
        else 
            @forumposts = Forumpost.search(params)
        end
    end


    def show
        @forumposts = Forumpost.find(params[:id])
        @forumposts.punch(request)
    end

    def tag_cloud
        @tags = Forumpost.tag_counts_on(:tags)
      end

    def markaccepted
        @forumpost = Forumpost.find(params[:id])
        if @forumpost.accepted == false
            (User.joins(:commentforums).where(commentforums: {forumpost_id: @forumpost.id}).uniq - [current_user]).uniq.each do |user|
                Notification.create(title: @forumpost.title, recipient: forumpost.user, actor: current_user, action: "resolved", notifiable: @forumpost)
            end
            @forumpost.update_attributes(accepted: true)
            @forumpost.tag_list.remove("unresolved")
            @forumpost.tag_list.add("resolved")
            @forumpost.save
        else 
            @forumpost.tag_list.remove("resolved")
            @forumpost.tag_list.add("unresolved")
            @forumpost.save
            @forumpost.update_attributes(accepted: false)
        end
        redirect_to request.referrer
    end

    private
    def forumpost_params
        params.require(:forumpost).permit(:content, :title, :tag_list => [])
    end
end
