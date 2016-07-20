require "rails_helper"

RSpec.describe Result, type: :model do
  describe "Associations" do
    it "belongs_to word" do
      is_expected.to belong_to :word
    end

    it "belongs_to answer" do
      is_expected.to belong_to :answer
    end

    it "belongs_to lesson" do
      is_expected.to belong_to :lesson
    end
  end
end
