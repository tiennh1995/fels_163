class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.not_admin
    @q = @users.ransack params[:q]
    @users = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
    @active = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
  end
end
