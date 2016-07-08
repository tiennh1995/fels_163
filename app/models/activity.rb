class Activity < ActiveRecord::Base
  belongs_to :user
  enum activity_type: [:follow, :new_category, :new_lesson]
end
