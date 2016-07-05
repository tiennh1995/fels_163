module ApplicationHelper
  def answer_class answer
    answer.is_correct? ? "correct_answer" : "well"
  end
end
