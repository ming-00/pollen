 json.array! @notifications do |notification|
    #json.recipient notification.recipient
    json.id notification.id
    json.actor notification.actor.firstname
    json.action notification.action
    json.title notification.title
    json.notifiable do
        json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
    end
    json.url entry_path(notification.notifiable.entry, anchor: dom_id(notification.notifiable))
end