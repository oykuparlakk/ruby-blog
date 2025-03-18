class Article < ApplicationRecord
  include Visible

  scope :not_archived, -> { where.not(status: "archived") }
  scope :published, -> { where("publish_at IS NULL OR publish_at <= ?", Time.current) }

  after_commit :schedule_publish, on: [ :create, :update ]

  def scheduled?
    publish_at.present? && publish_at > Time.current
  end

  private

  def schedule_publish
    if scheduled? && publish_at.present? && id.present?
      PublishArticleJob.set(wait_until: publish_at).perform_later(id)
    end
  end



  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :user
  has_many :recommendations, dependent: :destroy
  has_many :recommended_users, through: :recommendations, source: :recommended_user

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  accepts_nested_attributes_for :tags, allow_destroy: true

  has_rich_text :body

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "title", "body", "status", "publish_at" ]
  end
end
