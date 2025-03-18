class CommentsController < ApplicationController
  before_action :set_article
  before_action :authenticate_user!

  def create
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @article, notice: "Comment was successfully added." }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("comment_form", partial: "comments/form", locals: { article: @article, comment: @comment })
        end
        format.html { redirect_to @article, alert: "Comment could not be saved." }
      end
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])

    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to @article, notice: "Comment was successfully deleted." }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to @article, alert: "Comment could not be deleted." }
        format.turbo_stream { head :unprocessable_entity }
      end
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
