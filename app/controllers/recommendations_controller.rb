class RecommendationsController < ApplicationController
  before_action :set_article, only: [ :new, :create ]
  def new
    @recommendation = Recommendation.new

    respond_to do |format|
      format.html { render "recommendations/new", layout: false }
    end
  end

  def create
    @recommendation = @article.recommendations.new(recommendation_params)
    @recommendation.user = current_user

    if @recommendation.save
      redirect_to article_path(@article), notice: "Recommendation was successfully created."
    else
      flash[:error] = @recommendation.errors.full_messages.to_sentence
      render :new
    end
  end

  def index
    @recommendations = Recommendation.where(recommended_to: current_user.id).includes(:article, :user)
  end

  private

  def set_article
    if params[:article_id]
      @article = Article.find(params[:article_id])
    end
  end

  def recommendation_params
    params.require(:recommendation).permit(:recommended_to, :article_id)
  end
end
