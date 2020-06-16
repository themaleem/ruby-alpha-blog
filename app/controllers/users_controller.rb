class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Account was successfully created.'
      redirect_to action: 'show', id: @user.id
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User account was successfully updated'
      redirect_to @user
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
