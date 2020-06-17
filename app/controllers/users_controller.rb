class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update]
  before_action :same_user, only: %i[edit update destroy]

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

  def destroy
    @user.destroy
    session[:user_id] = nil if !current_user.admin?
    flash[:notice] = "Accounts and associated posts deleted. We'll miss you."
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def same_user
    if @user != current_user && !current_user.admin?
      flash[:error] = "Your can only edit your own profile."
      redirect_to @user
    end
  end

end
