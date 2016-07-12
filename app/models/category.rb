class Category < ActiveRecord::Base
  has_many :words
  has_many :lessons

  validates_presence_of :name
  validates_uniqueness_of :name

  include PublicActivity::Model
  tracked
end
