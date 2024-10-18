module SetArticle
  extend ActiveSupport::Concern

  included do 
    before_action :set_article
  end

  private
  def set_article
    @article = Article.find(params[:article_id] || params[:id])
  end
end