module Visible
  extend ActiveSupport::Concern

  def self.VALID_STATUSES
    I18n.t("visible.valid_statuses").keys.map(&:to_s)
  end

  included do
    validates :status, inclusion: { in: Visible.VALID_STATUSES }
  end

  class_methods do
    def public_count
      where(status: "public").count
    end
  end

  def archived?
    status == "archived"
  end
end
