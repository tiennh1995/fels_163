class Admin::WordsController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all
    @q = @words.ransack params[:q]
    @words = @q.result.joins(:category).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def show
  end

  def new
    @categories = Category.paginate page:
      params[:page], per_page: Settings.per_page
    @word.answers.build
  end

  def create
    if check_word? && @word.save
      flash[:success] = t "success"
      redirect_to [:admin, @word]
    else
      @categories = Category.paginate page:
        params[:page], per_page: Settings.per_page
      flash[:danger] = t "danger"
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :title, :category_id, :image,
      answers_attributes: [:id, :title, :is_correct, :_destroy]
  end

  def check_word?
    unless @word.answers.nil?
      @word.answers.each do |answer|
        return true if answer.is_correct?
      end
    end
    false
  end
end
