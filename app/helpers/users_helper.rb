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

    def tiny_avatar_for(user)
        case (user.id) % 6
            when 0
                image_tag 'profile1.png', :class => "mini-avatar", data: { toggle: 'tooltip' }, title: "#{user.firstname} #{user.lastname}"
            when 1
                image_tag 'profile2.png', :class => "mini-avatar", data: { toggle: 'tooltip' }, title: "#{user.firstname} #{user.lastname}"
            when 2
                image_tag 'profile3.png', :class => "mini-avatar", data: { toggle: 'tooltip' }, title: "#{user.firstname} #{user.lastname}"
            when 3
                image_tag 'profile4.png', :class => "mini-avatar", data: { toggle: 'tooltip' }, title: "#{user.firstname} #{user.lastname}"
            when 4
                image_tag 'profile5.png', :class => "mini-avatar", data: { toggle: 'tooltip' }, title: "#{user.firstname} #{user.lastname}"
            else
                image_tag 'profile6.png', :class => "mini-avatar", data: { toggle: 'tooltip' }, title: "#{user.firstname} #{user.lastname}"
        end
    end

    def award_for(user)
        case user.points
            when 0...5

            when 5...10

            when 10...20

            when 20...50

            else
        end
    end
end
