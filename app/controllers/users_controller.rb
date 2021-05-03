class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    (params[:user][:admin].nil? || params[:user][:admin] == 'no') ? @user.roles << Role.find_by(name: :employee) : @user.roles << Role.find_by(name: :admin)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to the Bookstore App!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end 

  def update
    if @user.update(user_params)
      flash[:success] = 'User updated successfully!'
      redirect_to @user 
    else
      render 'edit'
    end
  end

  def destroy 
    @user.destroy 
    flash[:success] = 'User deleted successfully!'
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
