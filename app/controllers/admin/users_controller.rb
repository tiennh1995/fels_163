class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.not_admin
    @q = @users.ransack params[:q]
    @users = @q.result.page(params[:page]).per Settings.per_page
  end

  def destroy
    if @user.destroy
      flash.now[:success] = t "destroy.success"
    else
      flash.now[:danger] = t "destroy.danger"
    end
    redirect_to admin_users_url
  end
end
