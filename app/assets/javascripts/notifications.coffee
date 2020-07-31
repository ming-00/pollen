# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @Notifications
    constructor: -> 
        @notifications = $("[data-behavior='notifications']")
        @setup() if @notifications.length >0

    setup: -> 
        $.ajax(
            url: "/notifications.json"
            dataType: "JSON"
            method: "GET"
            success: @handleSuccess
        )
        $("[data-behavior='notifications-link']").on "click", @handleClick

    handleClick: (e) =>
        $.ajax(
            url: "/notifications/mark_as_read"
            dataType: "JSON"
            method: "POST"
            success: ->
                $("[data-behavior='unread-count']").text(0)
                location.reload(true);
        )
    
    handleSuccess: (data) => 
        items = $.map data, (notification) -> 
            if notification.notifiable != undefined
                "<li>#{notification.title}: #{notification.actor} #{notification.action} #{notification.notifiable.type}. <a href='#{notification.url}'>view</a></li>"
        if items.length > 0
            $("[data-behavior='unread-count']").text(items.length)
            $("[data-behavior='notification-items']").html(items)
            $('#clear').show()
        else 
            $("[data-behavior='unread-count']").text(items.length)
            $("[data-behavior='notification-items']").html("No new notifications!")

jQuery -> 
    new Notifications