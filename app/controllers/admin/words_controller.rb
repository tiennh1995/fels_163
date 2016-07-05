class Admin::WordsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @words.ransack params[:q]
    @words = @q.result.joins(:category).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end
end
