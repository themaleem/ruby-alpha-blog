class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show
    @articles=@user.articles
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = 'Account was successfully created.'
      #   redirect_to action: 'show', id: @user.id
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User account was successfully updated'
      #  redirect_to root_path
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
