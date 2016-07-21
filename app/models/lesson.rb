class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :words, through: :results

  validates :user, presence: true
  validates :category, presence: true

  enum status: [:ready, :doing, :done]

  before_create :load_words
  after_create :create_activity_lesson

  accepts_nested_attributes_for :results

  scope :order_lesson, ->{order created_at: :desc}
  scope :in_month, ->(user_id) do
    where "user_id = ? AND created_at >= ?", user_id, 1.month.ago
  end

  def submit
    update_attributes status: 2
  end

  include PublicActivity::Model
  tracked only: :create, owner: Proc.new{|controller, model| controller.current_user}

  def sum_correct
    Result.sum_correct self.id
  end

  def total
    results.size
  end

  def load_answer_correct
    Result.sum_correct id
  end

  private
  def create_activity_lesson
    create_activity key: "new_lesson"
  end

  def load_words
    self.words = category.words.order("RANDOM()").limit Settings.number_word
  end
end
