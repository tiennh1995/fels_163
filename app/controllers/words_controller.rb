class WordsController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all
    @q = @words.ransack params[:q]
    @words = @q.result.joins(:category).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end
end
