module ForumpostsHelper
    def valid_tags
        Forumpost::TAGS.map{ |m| [ m ] }
      end
        
    def deco_for(tag)
        case (tag.id) % 5
            when 0
                link_to tag.name, tag_path(tag), class:"tag-deco-1"
            when 1
                link_to tag.name, tag_path(tag), class:"tag-deco-2"
            when 2
                link_to tag.name, tag_path(tag), class:"tag-deco-3"
            when 3
                link_to tag.name, tag_path(tag), class:"tag-deco-4"
            else
                link_to tag.name, tag_path(tag), class:"tag-deco-5"
            end
        end
end
