require "rails_helper"

RSpec.describe Word, type: :model do
  describe "Associations" do
    it "belongs_to category" do
      is_expected.to belong_to :category
    end

    it "should has_many results" do
      is_expected.to have_many :results
    end

    it "should has_many answers" do
      is_expected.to have_many :answers
    end
  end

  describe "Validations" do
    it{is_expected.to validate_presence_of :title}
  end

  describe "Nested attributes" do
    it{is_expected.to accept_nested_attributes_for :answers}
  end
end
