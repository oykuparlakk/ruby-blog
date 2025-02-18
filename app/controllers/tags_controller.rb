class TagsController < ApplicationController
  before_action :set_tag, only: %i[show edit update destroy]

  def index
    @tags = Tag.all
  end

 def show
    @tag = Tag.find(params[:id])
    @articles = @tag.articles.not_archived

    respond_to do |format|
      format.html { render "index" }
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("tab_#{@tag.id}_frame", partial: "articles/list", locals: { articles: @articles })
      end
    end
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path, notice: "Tag başarıyla oluşturuldu."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path, notice: "Tag başarıyla güncellendi."
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path, notice: "Tag başarıyla silindi."
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
