class Result < ActiveRecord::Base
  belongs_to :word
  belongs_to :answer
  belongs_to :lesson
end
