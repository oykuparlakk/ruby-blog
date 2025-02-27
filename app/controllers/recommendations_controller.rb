class RecommendationsController < ApplicationController
  before_action :set_article, only: [ :new, :create ]

  def new
    @recommendation = Recommendation.new
  end

  def create
    @recommendation = @article.recommendations.new(recommendation_params)
    @recommendation.user = current_user

    if @recommendation.save
      notice_message = "Recommendation was successfully created."
      respond_to do |format|
        format.html { redirect_to article_path(@article), notice: notice_message }
        format.turbo_stream { render turbo_stream: view_context.turbo_notification(notice_message) }
      end
    else
      error_message = @recommendation.errors.full_messages.to_sentence
      respond_to do |format|
        format.html { redirect_to article_path(@article), alert: error_message }
        format.turbo_stream { render turbo_stream: view_context.turbo_notification(error_message) }
      end
    end
  end

  def index
    @recommendations = Recommendation.where(recommended_to: current_user.id).includes(:article, :user)
  end

  private

  def set_article
    @article = Article.find(params[:article_id]) if params[:article_id]
  end

  def recommendation_params
    params.require(:recommendation).permit(:recommended_to, :article_id)
  end
end
