class ArticlesController < ApplicationController
  # instruct set_article() method to be called before the listed 'only' methods
  before_action :set_article, only: %i[edit update show destroy]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: %i[edit update destroy]

  def show; end

  def index
    # paginated article
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # instantiate an new and empty article instance
  def new
    @article = Article.new
  end

  # recieves POST request from /new and persists the database with recieved data
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = 'Article was successfully created.'
      redirect_to action: 'show', id: @article.id
    else
      render 'new'
    end
  end

  def edit; end

  # recieves POST request from /edit and update instance the database with recieved data
  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated to: #{@article.title}"
      redirect_to @article
    else
      render 'edit'
    end
  end

  # recieves DELETE request with article id and deletes its instance from database
  def destroy
    if @article.destroy
      flash[:notice] = 'Article was successfully deleted.'
      redirect_to articles_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to 'home'
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if @article.user != current_user
      flash[:notice] = "Only article owner can perform this operation."
      redirect_to @article
    end
  end
end
