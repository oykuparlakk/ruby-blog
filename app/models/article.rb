class Article < ApplicationRecord
  include Visible

  scope :not_archived, -> { where.not(status: "archived") }
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :user
  has_many :recommendations, dependent: :destroy
  has_many :recommended_users, through: :recommendations, source: :recommended_user

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "title", "body", "status" ]
  end
end
