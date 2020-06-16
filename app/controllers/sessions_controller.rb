class SessionsController < ApplicationController
  def new; end

  # login and add user_id to session
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in successfully'
      redirect_to user
    else
      flash.now[:error] = 'There was a problem signing you in. Please try again'
      render 'new'
    end
  end
  # remove user id from session
  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out'
    redirect_to root_path
  end
end
