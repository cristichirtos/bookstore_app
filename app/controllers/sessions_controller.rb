class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid username or password.'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = 'Logged out successfully. See you next time!'
    redirect_to login_path
  end
end
