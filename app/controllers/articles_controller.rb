class ArticlesController < ApplicationController
  include SetArticle

  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @locale = params[:locale] || I18n.default_locale
    @query = Article.not_archived.ransack(params[:query])
    @pagy, @articles = pagy(@query.result(distinct: true), items: 10)
    Rails.logger.debug "Articles from index: #{@articles.map(&:title).inspect}"
  end



  def search
    @query = Article.ransack(params[:query])
    Rails.logger.debug "Ransack query: #{@query.inspect}"
    @pagy, @articles = pagy(@query.result(distinct: true))
    Rails.logger.debug "Articles found: #{@articles.map(&:title).inspect}"
    render :index
  end

  def show
    if @article.nil?
      redirect_to articles_path, alert: "Article not found."
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article, locale: I18n.locale)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
