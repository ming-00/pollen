 json.array! @notifications do |notification|
    #json.recipient notification.recipient
    json.id notification.id
    json.actor notification.actor.firstname
    json.action notification.action
    json.title notification.title
    json.notifiable do
        if (notification.notifiable.is_a? Entry) 
            json.type "an #{notification.notifiable.model_name.human.downcase}"
        elsif (notification.notifiable.is_a? Entry)
            json.type "a #{notification.notifiable.model_name.human.downcase}"
        elsif (notification.notifiable.is_a? User)
            json.type "you"
        end
    end
    if (notification.notifiable.is_a? Correction) 
        json.url entry_path(notification.notifiable.entry)
    elsif (notification.notifiable.is_a? Entry)
        json.url entry_path(notification.notifiable)
    elsif (notification.notifiable.is_a? User)
        json.url user_path(notification.actor)
    end
end