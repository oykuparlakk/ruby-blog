class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article

  after_create_commit { broadcast_likes }
  after_destroy_commit { broadcast_likes }

  private

  def broadcast_likes
    article.broadcast_replace_to "likes_count", target: "article_#{article.id}_likes_count", partial: "articles/like_count", locals: { article: article }
  end
end
