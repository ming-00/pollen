module ForumpostsHelper
    def valid_tags
        Forumpost::TAGS.map{ |m| [ m ] }
      end
end
