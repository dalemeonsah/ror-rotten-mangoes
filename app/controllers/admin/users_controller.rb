class Admin::UsersController < ApplicationController

  before_filter :restrict_access_admin

  def index
    @users = User.all.page(params[:page]).per(2)
  end
  
end