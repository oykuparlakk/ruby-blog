class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read_at: nil) }
  scope :read, -> { where.not(read_at: nil) }

  after_create_commit do
    broadcast_append_to "notifications_#{user.id}",
      target: "notifications",
      partial: "notifications/notification",
      locals: { notification: self }

    broadcast_update_to "notification_count_#{user.id}",
      target: "notification_count",
      partial: "notifications/notification_count",
      locals: { user: user }
  end

  after_destroy_commit do
    broadcast_remove_to "notifications_#{user.id}", target: "notification_#{id}"

    broadcast_update_to "notification_count_#{user.id}",
      target: "notification_count",
      partial: "notifications/notification_count",
      locals: { user: user }
  end

  def read?
    read_at.present?
  end
end
