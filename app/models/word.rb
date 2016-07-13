class Word < ActiveRecord::Base
  belongs_to :category

  has_many :results
  has_many :answers

  validates_presence_of :title
  validates_uniqueness_of :title

  mount_uploader :picture, PictureUploader

  scope :learned, ->(user_id) do
    Word.eager_load(:results).where "lesson_id IN
    (SELECT lesson_id FROM users LEFT OUTER JOIN lessons ON
    lessons.user_id = users.id WHERE users.id = :id)", id: user_id
  end
  scope :not_learn, ->(user_id) do
    Word.eager_load(:results)
    .where.not "lesson_id IN (SELECT lesson_id FROM users LEFT OUTER JOIN
    lessons ON lessons.user_id = users.id WHERE users.id = :id)", id: user_id
  end

  accepts_nested_attributes_for :answers,
    reject_if: lambda {|a| a[:title].blank?}, allow_destroy: true
end
