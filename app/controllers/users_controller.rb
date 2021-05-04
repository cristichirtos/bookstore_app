require_relative '../services/user_service'
require_relative '../models/dto/user_dto'

class UsersController < ApplicationController
  before_action :set_service

  def index
    @users = @user_service.find_all
  end

  def new
    @user = User.new
  end

  def show
    @user = @user_service.find_by_id(params[:id])
  end

  def create
    userDTO = UserDTO.new(user_params.to_h)
    @user = @user_service.register(userDTO)
    if @user.errors.empty?
      log_in @user
      flash[:success] = 'Welcome to the Bookstore App!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = @user_service.find_by_id(params[:id])
  end 

  def update
    @user = @user_service.update_by_id(params[:id], user_params)
    unless @user.nil?
      flash[:success] = 'User updated successfully!'
      redirect_to @user 
    else
      render 'edit'
    end
  end

  def destroy 
    @user_service.delete_by_id(params[:id])
    flash[:success] = 'User deleted successfully!'
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :admin)
    end

    def set_service 
      @user_service = UserService.new
    end
end
