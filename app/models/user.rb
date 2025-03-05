class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, [ :user, :admin ], prefix: true

  has_many :articles, dependent: :destroy
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  has_many :recommendations, dependent: :destroy
  has_many :recommended_articles, through: :recommendations, source: :article

  has_many :likes
  has_many :liked_articles, through: :likes, source: :article
  has_many :notifications, dependent: :destroy
  def full_name
    "#{first_name} #{last_name}".strip
  end
end
