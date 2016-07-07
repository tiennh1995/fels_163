class WordsController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all
    @words = (params[:type].nil? || params[:type] == "all") ? @words :
      @words.send("#{params[:type]}", current_user.id)
    @q = @words.ransack params[:q]
    @words = @q.result.joins(:category).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end
end
