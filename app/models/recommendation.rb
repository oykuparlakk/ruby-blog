class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :recommended_user, class_name: "User", foreign_key: "recommended_to"

  validates :recommended_to, presence: true
  validate :cannot_recommend_to_self

  after_create :send_recommendation_email
  after_create_commit :notify_recipient

  private

  def cannot_recommend_to_self
    if recommended_to == user.id
      errors.add(:recommended_to, "kendine öneri gönderemezsin")
    end
  end

  def send_recommendation_email
    RecommendationMailer.recommendation_email(self).deliver_now
  end

  private

  def notify_recipient
    recipient = User.find(recommended_to)
    Notification.create!(
      user: recipient,
      notifiable: self
    )
  end
end
