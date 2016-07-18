class WordsController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.includes :words
    @words = (params[:type].nil? || params[:type] == "all") ? @words :
      @words.send("#{params[:type]}", current_user.id)
    @q = @words.ransack params[:q]
    @words = @q.result.page(params[:page]).per Settings.per_page
  end
end
