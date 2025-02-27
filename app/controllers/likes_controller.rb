class LikesController < ApplicationController
  before_action :set_article

  def create
    @like = @article.likes.create(user: current_user)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @article }
    end
  end

  def destroy
    @like = @article.likes.find_by(user: current_user)
    @like.destroy if @like
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @article }
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end
end
