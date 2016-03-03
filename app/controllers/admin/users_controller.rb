class Admin::UsersController < ApplicationController

  before_filter :restrict_access_admin

  def index
    @users = User.all.page(params[:page]).per(2)
  end

  def new
    @user = User.new 
    render '/users/new'
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end
  
  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end