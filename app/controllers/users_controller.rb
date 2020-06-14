class UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end 
end
