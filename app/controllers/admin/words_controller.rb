class Admin::WordsController < Admin::AdminController
  load_and_authorize_resource
  before_action :load_category, except: [:show, :index, :destroy]

  def index
    @categories = Category.includes :words
    @q = @words.ransack params[:q]
    @words = @q.result.joins(:category).page(params[:page]).per Settings.per_page
  end

  def show
  end

  def new
  end

  def create
    if @word.save
      flash[:success] = t :success
      redirect_to [:admin, @word]
    else
      render :new
    end
  end

  def edit
  end

  def update
    unless @word.update_attributes word_params
      render :edit
    else
      flash[:success] = t :success
      redirect_to [:admin, @word]
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t :success
    else
      flash[:danger] = t :danger
    end
    redirect_to admin_words_path
  end

  private
  def word_params
    params.require(:word).permit :title, :category_id, :picture,
      answers_attributes: [:id, :title, :is_correct, :_destroy]
  end

  def load_category
    @categories = Category.page(params[:page]).per Settings.per_page
    @category = @categories.find_by_id params[:category_id]
  end
end
