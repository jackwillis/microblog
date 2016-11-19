module NotificationsHelper
  def render_notification_partial(notification)
    subject_types = [:follow, :post_like]

    locals = Hash[
      subject_types.map { |s_type| [s_type, notification.send(s_type)] }
    ]

    render "notifications/#{notification.subject_type.underscore}", locals
  end
end
