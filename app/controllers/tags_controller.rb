class TagsController < ApplicationController
    def index
        @tags = ActsAsTaggableOn::Tag.all
    end
    
    def show
        @tag =  ActsAsTaggableOn::Tag.find(params[:id])
        current_user.taglist << @tag.name
        @forumpostss = Forumpost.tagged_with(@tag.name)
        current_user.taglist.each do |tag|

            @forumpostss = @forumpostss.tagged_with(tag)
        end
        @forumposts = @forumpostss
    end
end
