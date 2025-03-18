class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  belongs_to :user

  validates :content, presence: true

  before_validation :set_default_status
  after_create_commit :send_notification_to_article_author
  after_destroy_commit :remove_notification

  private

  def set_default_status
    self.status ||= "public"
  end

  def send_notification_to_article_author
    return if user == article.user

    Notification.create!(
      user: article.user,
      notifiable: self
    )
  end

  def remove_notification
    Notification.find_by(notifiable: self)&.destroy
  end
end
