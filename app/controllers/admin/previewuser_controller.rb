class Admin::PreviewuserController < ApplicationController
  
  before_filter :authorize_admin

  def new
    session[:admin_id] = current_user.id
    user = User.find(params[:user_id])
    #sign_in(user) TODO: login as preview
    redirect_to admin_users_path, notice: "Now previewing as #{user.firstname}"
  end

  def destroy
    #user = User.find(session[:admin_id])
    #sign_in :user, user TODO: login back as admin
    session[:admin_id] = nil
    redirect_to admin_users_path, notice: "Stopped previewing"
  end
end
