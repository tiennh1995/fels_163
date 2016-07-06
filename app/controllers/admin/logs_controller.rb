class Admin::LogsController < ApplicationController
  load_and_authorize_resource

  def index
    @logs = @logs.paginate page: params[:page], per_page: Settings.per_page
  end
end
