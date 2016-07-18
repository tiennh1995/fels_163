class Admin::ActivitiesController < Admin::AdminController
  def index
    @activities = PublicActivity::Activity.all.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end
end
