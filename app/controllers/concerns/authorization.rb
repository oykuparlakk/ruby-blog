module Authorization
  extend ActiveSupport::Concern

  included do
    before_action :authorize_author_or_admin, only: [ :edit, :update, :destroy ]
  end

  private

  def authorize_author_or_admin
    if !authorized_for_article? && !current_user&.role_admin?
      redirect_to root_path, alert: "Bu işlem için yetkiniz yok!"
    end
  end

  def authorized_for_article?
    return false unless action_requires_article?
    article = Article.find(params[:id])
    article.user == current_user || current_user&.role_admin?
  end

  def action_requires_article?
    params[:controller] == "articles" && params[:id].present?
  end
end
