class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { user: 0, admin: 2 }
  has_many :articles, dependent: :destroy
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  def admin?
    role == "admin"
  end

  def user?
    role == "user"
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def update_without_password(params)
    params.delete(:password)
    params.delete(:password_confirmation)
    update(params)
  end
end
