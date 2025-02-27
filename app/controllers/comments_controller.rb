class CommentsController < ApplicationController
  include SetArticle

  before_action :set_article, only: [ :create, :destroy ]

  def create
    @comment = @article.comments.build(comment_params)
    if @comment.save
      notice_message = "Comment was successfully created."
      respond_to do |format|
        format.html { redirect_to @article, notice: notice_message }
        format.turbo_stream { render turbo_stream: view_context.turbo_notification(notice_message) }
      end
    else
      render "articles/show"
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    notice_message = "Comment was successfully destroyed."
    respond_to do |format|
      format.html { redirect_to article_path(@article), status: :see_other, notice: notice_message }
      format.turbo_stream { render turbo_stream: view_context.turbo_notification(notice_message) }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
