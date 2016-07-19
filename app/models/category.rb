class Category < ActiveRecord::Base
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  include PublicActivity::Model
  tracked
end
