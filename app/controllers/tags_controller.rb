class TagsController < ApplicationController
    def index
        @tags = ActsAsTaggableOn::Tag.all
    end
    
    def show
        @tag =  ActsAsTaggableOn::Tag.find(params[:id])
        User.update_all(['tagarray = array_append(tagarray, ?)', @tag.name])
        @forumpostss = Forumpost.tagged_with(@tag.name)
        current_user.tagarray.each do |tag|

            @forumpostss = @forumpostss.tagged_with(tag)
        end
        @forumposts = @forumpostss
    end
end
