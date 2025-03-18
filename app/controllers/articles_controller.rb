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
      redirect_to articles_path, alert: "Article not found." and return
    end
    @recommendation = Recommendation.new(article: @article)
    render :show, layout: "article_show"
  end

  def new
    @article = Article.new
    @article.tags.build
  end

  def create
    @article = current_user.articles.new(article_params)
    if params[:article][:schedule_publish] == "1" && params[:article][:publish_at].present?
      @article.publish_at = Time.zone.parse(params[:article][:publish_at])
      @article.status = "scheduled"
    else
      @article.publish_at = nil
      @article.status = "public"
    end

    if @article.save
      notice_message = @article.scheduled? ? "Makale planlandı, belirtilen tarihte yayınlanacak." : "Makale başarıyla oluşturuldu."
      respond_to do |format|
        format.html { redirect_to article_path(@article), notice: notice_message }
        format.turbo_stream { render turbo_stream: view_context.turbo_notification(notice_message) }
      end
    else
      render :new, alert: "Makale oluşturulamadı"
    end
  end




  def edit
  end

  def update
    if @article.update(article_params)
      notice_message = "Makale başarıyla güncellendi."
      respond_to do |format|
        format.html { redirect_to article_path(@article), notice: notice_message }
        format.turbo_stream { render turbo_stream: view_context.turbo_notification(notice_message) }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    notice_message = "Makale başarıyla silindi."
    respond_to do |format|
      format.html { redirect_to articles_path, status: :see_other, notice: notice_message }
      format.turbo_stream { render turbo_stream: view_context.turbo_notification(notice_message) }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :status, :image, :publish_at, tag_ids: [])
  end
end
