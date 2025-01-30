class RecommendationsController < ApplicationController
  before_action :set_article

  def new
    @recommendation = Recommendation.new
  end

  def create
    @article = Article.find(params[:article_id])
    @recommendation = @article.recommendations.new(recommendation_params)
    @recommendation.user = current_user

    if @recommendation.save
      redirect_to article_path(@article, locale: I18n.locale), notice: "Recommendation was successfully created."
    else
      flash[:error] = @recommendation.errors.full_messages.to_sentence
      render :new
    end
  end



  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def recommendation_params
    params.require(:recommendation).permit(:recommended_to, :article_id)
  end
end
