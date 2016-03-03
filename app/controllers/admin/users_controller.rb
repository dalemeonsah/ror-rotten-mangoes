class Admin::UsersController < ApplicationController

  before_filter :restrict_access_admin

  def index
    @users = User.all  
  end
  
end