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

 
  def create
    @new_article =
      Article.new(params.require(:article).permit(:title, :description))

    if @new_article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to action: 'show', id: @new_article.id
    else
      # redirect_to @new_article
      render 'new'
    end
  end
end