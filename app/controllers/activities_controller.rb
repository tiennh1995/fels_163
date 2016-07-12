class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.all_activity(current_user.id)
      .page(params[:page]).per Settings.per_page
  end
end
