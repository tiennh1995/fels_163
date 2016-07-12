class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @categories.ransack params[:q]
    @categories = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
    if @category.nil?
      flash[:danger] = t :category_fails
      redirect_to admin_categories_path
    else
      @search = @category.words.ransack params[:q]
      @words = @search.result.page(params[:page]).per Settings.per_page
      @word = @category.words.build
      @word.answers.build
    end
  end

  def new
  end

  def destroy
    if @category.destroy
      flash[:success] = t :success
      redirect_to categories_path
    else
      flash[:danger] = t :danger
      redirect_to @category
    end
  end

  def create
    if @category.save
      flash[:success] = t "category.created_category"
      Notification.new(@category).notify_new_category
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def destroy
    Notification.new(@category).notify_delete_category
    if @category.destroy
      flash[:success] = t :delele_success
    else
      flash[:danger] = t :delete_fail
    end
    redirect_to :back
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
