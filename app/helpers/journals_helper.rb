module JournalsHelper
    def cover_for(journal)
        case (journal.id) % 7
            when 0
                image_tag 'cover1.png', :class => "journal-cover"
            when 1
                image_tag 'cover2.png', :class => "journal-cover"
            when 2
                image_tag 'cover3.png', :class => "journal-cover"
            when 3
                image_tag 'cover4.png', :class => "journal-cover"
            when 4
                image_tag 'cover5.png', :class => "journal-cover"
            when 5
                image_tag 'cover6.png', :class => "journal-cover"
            else
                image_tag 'cover7.png', :class => "journal-cover"
        end
    end
end
