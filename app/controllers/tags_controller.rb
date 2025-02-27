class TagsController < ApplicationController
  before_action :set_tag, only: %i[show edit update destroy]

  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "articles_frame",
          partial: "articles/list",
          locals: { articles: @tag.articles.not_archived }
        )
      end
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      notice_message = "Tag başarıyla oluşturuldu."
      respond_to do |format|
        format.html { redirect_to tags_path, notice: notice_message }
        format.turbo_stream { render turbo_stream: view_context.turbo_notification(notice_message) }
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      notice_message = "Tag başarıyla güncellendi."
      respond_to do |format|
        format.html { redirect_to tags_path, notice: notice_message }
        format.turbo_stream { render turbo_stream: view_context.turbo_notification(notice_message) }
      end
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    notice_message = "Tag başarıyla silindi."
    respond_to do |format|
      format.html { redirect_to tags_path, notice: notice_message }
      format.turbo_stream { render turbo_stream: view_context.turbo_notification(notice_message) }
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
