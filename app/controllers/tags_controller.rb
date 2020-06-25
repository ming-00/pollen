class TagsController < ApplicationController
    def index
        @tags = ActsAsTaggableOn::Tag.all
    end
    
    def show
        @tag =  ActsAsTaggableOn::Tag.find(params[:id])
        @forumposts = Forumpost.tagged_with(@tag.name)
    end
end
