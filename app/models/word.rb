class Word < ActiveRecord::Base
  belongs_to :category

  has_many :results
  has_many :answers
  validates :title, uniqueness: true

  mount_uploader :image, ImageUploader

  accepts_nested_attributes_for :answers,
    reject_if: lambda {|a| a[:title].blank?}, allow_destroy: true
end
