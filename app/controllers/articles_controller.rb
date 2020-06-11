class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @new_article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @new_article =
      Article.new(params.require(:article).permit(:title, :description))

    if @new_article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to action: 'show', id: @new_article.id
    else
      render 'new'
    end
  end

  def update
    byebug
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = 'Article was successfully updated.'
      redirect_to @article
    else
      render 'edit'
    end
  end
end
