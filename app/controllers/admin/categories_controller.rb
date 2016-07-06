class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @categories.ransack params[:q]
    @categories = @q.result.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
    if @category.nil?
      flash[:danger] = t :category_fails
      redirect_to admin_categories_path
    else
      @search = @category.words.ransack params[:q]
      @words = @search.result.paginate page: params[:page],
        per_page: Settings.per_page
      @word = @category.words.build
      @word.answers.build
    end
  end

  def new
  end

  def create
    if @category.save
      flash[:success] = t "category.created_category"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
