module NotificationsHelper
  def render_notification_partial(notification)
    subject_types = [:follow, :post_like]

    locals = Hash[
      subject_types.map { |s_type| [s_type, notification.send(s_type)] }
    ]

    render "notifications/#{notification.subject_type.underscore}", locals
  end

  def notifications_link
    unreads = current_user.unread_notifications_count

    message = if unreads.zero?
      "Notifications"
    else
      "Notifications (#{unreads})"
    end

    link_to message, notifications_path 
  end
end
