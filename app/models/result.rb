class Result < ActiveRecord::Base
  belongs_to :word
  belongs_to :answer
  belongs_to :lesson

  scope :word_in_month, ->(user_id) do
    joins("LEFT JOIN lessons ON lessons.id = results.lesson_id")
     .where("user_id = ? AND results.created_at >= ? AND results.answer_id IN
      (SELECT id FROM answers WHERE is_correct = 't' AND
      word_id = results.word_id )", user_id, 1.month.ago).distinct.count :word_id
  end
  scope :sum_correct, ->(lesson_id) do
    where("lesson_id = ? AND results.answer_id IN (SELECT id FROM answers
     WHERE is_correct = 't' AND word_id = results.word_id)").size
  end
end
