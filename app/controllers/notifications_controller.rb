class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications
      .with_polymorphic_preloads.order(created_at: :desc)

    render

    Thread.new do
      @notifications.update_all(read_at: Time.zone.now)
    end
  end
end
