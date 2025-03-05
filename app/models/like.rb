class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article

  after_create_commit { broadcast_likes }
  after_destroy_commit { broadcast_likes }
  after_create_commit :notify_author
  after_destroy_commit :remove_notification


  private

  def broadcast_likes
    article.broadcast_replace_to "likes_count", target: "article_#{article.id}_likes_count", partial: "articles/like_count", locals: { article: article }
  end

  private

  def notify_author
    return if article.user == user

    Notification.create!(
      user: article.user,
      notifiable: self
    )
  end

  def remove_notification
    notification = Notification.find_by(user: article.user, notifiable: self)
    notification&.destroy
  end
end
