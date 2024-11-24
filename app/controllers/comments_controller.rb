class CommentsController < ApplicationController
  include SetArticle

  before_action :set_article, only: [ :create, :destroy ]

  def create
    @comment = @article.comments.build(comment_params)
    if @comment.save
      redirect_to @article, notice: "Comment was successfully created."
    else
      render "articles/show"
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body, :status)
  end
end
