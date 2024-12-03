module Authorization
  extend ActiveSupport::Concern

  included do
    before_action :authorize_author_or_admin, only: [ :new, :create, :edit, :update, :destroy ]
  end

  private

  def authorize_author_or_admin
    unless current_user&.admin? || current_user&.author?
      redirect_to root_path, alert: "Bu işlem için yetkiniz yok!"
    end
  end
end
