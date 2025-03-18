class PublishArticleJob < ApplicationJob
  queue_as :default

  def perform(article_id)
    article = Article.find_by(id: article_id)
    return unless article && article.status == "scheduled"

    article.update(status: "public")
  end
end
