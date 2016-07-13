class LessonWorker
  include Sidekiq::Worker

  def perform lesson_id
    lesson = Lesson.find_by_id lesson_id
    UserMailer.send_destroy_lesson lesson
    lesson.destroy
  end
end
