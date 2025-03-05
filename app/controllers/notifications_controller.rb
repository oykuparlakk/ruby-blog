class NotificationsController < ApplicationController
  before_action :authenticate_user!

  helper NotificationsHelper

  def index
    @notifications = current_user.notifications.unread.order(created_at: :desc)
  end

  def mark_as_read
    notification = current_user.notifications.find(params[:id])
    notification.update!(read_at: Time.current)

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(notification) }
      format.html { redirect_to notifications_path }
    end
  end
end
