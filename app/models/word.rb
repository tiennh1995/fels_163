class Word < ActiveRecord::Base
  belongs_to :category

  has_many :results
  has_many :answers
end
