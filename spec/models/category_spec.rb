require "rails_helper"

RSpec.describe Category, type: :model do
  describe "Associations" do
    it {is_expected.to have_many :lessons}
    it {is_expected.to have_many :words}
  end

  describe "Validations" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_uniqueness_of :name}
  end
end
