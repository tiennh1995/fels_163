class StaticPagesController < ApplicationController
  def home
    @activities = PublicActivity::Activity.all_activity(current_user.id)
      .page(params[:page]).per Settings.per_page
  end

  def help
  end

  def about
  end
end
