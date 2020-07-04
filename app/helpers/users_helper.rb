module UsersHelper
    def avatar_for(user)
        case (user.id) % 6
            when 0
                image_tag 'profile1.png', :class => "avatar"
            when 1
                image_tag 'profile2.png', :class => "avatar"
            when 2
                image_tag 'profile3.png', :class => "avatar"
            when 3
                image_tag 'profile4.png', :class => "avatar"
            when 4
                image_tag 'profile5.png', :class => "avatar"
            else
                image_tag 'profile6.png', :class => "avatar"
        end
    end
end
