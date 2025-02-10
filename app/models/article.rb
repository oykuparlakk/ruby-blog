class Article < ApplicationRecord
  include Visible

  scope :not_archived, -> { where.not(status: "archived") }
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :user
  has_many :recommendations, dependent: :destroy
  has_many :recommended_users, through: :recommendations, source: :recommended_user

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  accepts_nested_attributes_for :tags, allow_destroy: true

  has_rich_text :body


  def self.ransackable_attributes(auth_object = nil)
    [ "id", "title", "body", "status" ]
  end
end
