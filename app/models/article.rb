class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }


  def self.ransackable_attributes(auth_object = nil)
    [ "title", "status" ]
  end
end
