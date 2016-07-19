class Word < ActiveRecord::Base
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates_presence_of :title

  validate :check_word
  before_save :check_word

  mount_uploader :picture, PictureUploader

  scope :learned, ->(user_id) do
    where("id IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT id FROM lessons WHERE user_id = :id))", id: user_id)
  end

  scope :not_learn, ->(user_id) do
    where("id NOT IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT id FROM lessons WHERE user_id = :id))", id: user_id)
  end

  accepts_nested_attributes_for :answers,
    reject_if: lambda {|a| a[:title].blank?}, allow_destroy: true

  private
  def check_word
    check_nil = true
    check_true = true
    if answers.blank?
      check_nil = false
    else
      answers.each do |answer|
        check_true = false if answer.try :is_correct?
      end
    end
    errors.add :answer, I18n.t(:answer_blank) unless check_nil
    errors.add :answer, I18n.t(:answer_uncorrect) unless check_true == false
  end
end
