class UserMailer < ApplicationMailer
  default from: Settings.mail_from

  def statistic_email user
    @content = {words:user.words_in_month, lesson: user.lesson_in_month,
      categories: user.category_in_month, name: user.name}
    mail to: user.email,
      subject: I18n.t("user_mailer.send_result.subject")
  end

  def send_result lesson
    @content = {name: lesson.user.name, correct: lesson.sum_correct,
      id: lesson.id, total: lesson.total}
    mail to: lesson.user.email,
      subject: I18n.t("user_mailer.send_result.subject")
  end

  def send_destroy_lesson lesson
    @content = {name: lesson.user.name, id: lesson.id}
    mail to: lesson.user.email,
      subject: I18n.t("user_mailer.statistic_email.subject")
  end
end
