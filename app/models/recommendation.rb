class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :article
  belongs_to :recommended_user, class_name: "User", foreign_key: "recommended_to"
  validates :recommended_to, presence: true
  validate :cannot_recommend_to_self

  private

  def cannot_recommend_to_self
    if recommended_to == user
      errors.add(:recommended_to, "cannot be yourself")
    end
  end
end
