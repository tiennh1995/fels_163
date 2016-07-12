class Admin::LogsController < ApplicationController
  load_and_authorize_resource

  def index
    @logs = @logs.page(params[:page]).per Settings.per_page
  end
end
