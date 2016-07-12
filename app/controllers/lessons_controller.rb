class LessonsController < ApplicationController
  load_and_authorize_resource :category
  load_and_authorize_resource
  before_action :load_info_lesson, only: [:show, :update]

  def index
    @categories = Category.all
    @lessons = current_user.lessons.order_lesson
    @q = @lessons.ransack params[:q]
    @lessons = @q.result.joins(:category).paginate page: params[:page],
      per_page: Settings.per_page
  end

  def create
    @lesson.user = current_user
    if @lesson.save
      redirect_to [@category, @lesson]
    else
      flash[:danger] = t :danger
      redirect_to categories_path
    end
  end

  def show
  end

  def update
    if @lesson.update_attributes lesson_params
      @lesson.delay_for(Settings.time_lesson.seconds).submit if @lesson.doing?
      redirect_to [@category, @lesson]
    else
      flash[:danger] = t :danger
      render :show
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :status, :category_id,
      results_attributes: [:id, :answer_id]
  end

  def load_info_lesson
    @time_lesson = Settings.time_lesson - (Time.now.to_i -
      @lesson.updated_at.to_time.to_i)
    if @time_lesson <= 0 or @lesson.done?
      @time_lesson = 0
    end
    @count = 0
    @lesson.results.each do |e|
      if e.answer.present?
        @count = @count.next
      end
    end
  end
end
