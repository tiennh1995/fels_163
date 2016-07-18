class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @categories.ransack params[:q]
    @categories = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
    @q = @category.words.ransack params[:q]
    @words = @q.result.page(params[:page]).per Settings.per_page
    @lesson = @category.lessons.build
    @lesson.user = current_user
  end
end
