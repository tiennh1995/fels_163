class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @categories.ransack params[:q]
    @categories = @q.result.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    if @category.nil?
      flash[:danger] = t :category_fails
      redirect_to categories_path
    else
      @search = @category.words.ransack params[:q]
      @words = @search.result.paginate page: params[:page],
        per_page: Settings.per_page
    end
  end
end
