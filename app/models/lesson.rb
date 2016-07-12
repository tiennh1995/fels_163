class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :words, through: :results

  enum status: [:ready, :doing, :done]

  before_create :load_words

  accepts_nested_attributes_for :results

  scope :order_lesson, ->{order created_at: :desc}

  def submit
    update_attributes status: 2
  end

  private
  def load_words
    self.words = category.words.order("RANDOM()").limit Settings.number_word
  end
end
