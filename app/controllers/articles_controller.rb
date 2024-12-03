class ArticlesController < ApplicationController
  include SetArticle
  include Authorization

  before_action :authenticate_user!
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
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
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to article_path(@article, locale: I18n.locale), notice: "Makale başarıyla oluşturuldu."
    else
      render :new, alert: "Makale oluşturulamadı"
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article, locale: I18n.locale), notice: "Makale başarıyla güncellendi."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path(locale: I18n.locale), status: :see_other, notice: "Makale başarıyla silindi."
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
