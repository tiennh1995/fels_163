class StaticPagesController < ApplicationController
  before_action :check_admin

  def home
    @activities = PublicActivity::Activity.all_activity(current_user.id)
      .limit(Settings.per_page).order(created_at: :desc).page(params[:page])
      .per Settings.per_page
    @lessons = current_user.lessons.limit Settings.per_page
  end

  def help
  end

  def about
  end

  private
  def check_admin
    redirect_to admin_root_path if current_user.try :is_admin?
  end
end
