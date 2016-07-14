class Admin::WordsController < Admin::AdminController
  load_and_authorize_resource
  before_action :load_category, except: [:show, :index, :destroy]


  def index
    @categories = Category.all
    @q = @words.ransack params[:q]
    @words = @q.result.joins(:category).page(params[:page]).per Settings.per_page
  end

  def show
  end

  def new
    @word.answers.build
  end

  def create
    if @word.save
      flash[:success] = t :success
      redirect_to [:admin, @word]
    else
      flash[:danger] = t :danger
      render :new
    end
  end

  def edit
  end

  def update
    if check_word_params? && @word.update_attributes(word_params)
      respond_to do |format|
        format.html {redirect_to [:admin, @word]}
        format.js
      end
    else
      flash[:danger] = t :danger
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
    params.require(:word).permit :title, :category_id, :image,
      answers_attributes: [:id, :title, :is_correct, :_destroy]
  end

  def check_word_params?
    unless params[:word][:answers_attributes].nil?
      params[:word][:answers_attributes].values.each do |p|
        return true if p["is_correct"] == "1"
      end
    end
    false
  end

  def load_category
    @categories = Category.page(params[:page]).per Settings.per_page
    @category = @categories.find_by_id params[:category_id]
  end
end
