class Admin::CategoriesController < Admin::AdminController
  load_and_authorize_resource

  def index
    @q = @categories.ransack params[:q]
    @categories = @q.result.page(params[:page]).per Settings.per_page
  end

  def show
    @q = @category.words.ransack params[:q]
    @words = @q.result.page(params[:page]).per Settings.per_page
    @word = @category.words.build
    @word.answers.build
  end

  def new
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
      flash[:success] = t :success
    else
      flash[:danger] = t :fail
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
