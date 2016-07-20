require "rails_helper"
PublicActivity.without_tracking do
  RSpec.describe User, type: :model do
    let(:user) {FactoryGirl.create :user}

    describe "Associations" do
      it {is_expected.to have_many(:logs).dependent(:destroy)}
      it {is_expected.to have_many(:identities).dependent(:destroy)}
      it {is_expected.to have_many(:lessons).dependent(:destroy)}
    end

    describe "Validations" do
      it {is_expected.to validate_presence_of :email}
      it do
        is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(30)
      end

      context "if email required" do
        before {allow(user).to receive(:email_required?).and_return(true)}
        it {is_expected.to validate_presence_of :email}
      end

      describe "Follow relationship" do
        let(:another_user) {FactoryGirl.create :user}

        context "when follow another user" do
          it {expect(user.follow another_user).to be_valid}
        end

        context "when unfollow another user" do
          before {user.follow another_user}
          it {expect(user.unfollow another_user).to be_valid}
        end

        context "following? another user" do
          before {user.follow another_user}
          it {expect(user.following? another_user).to be true}
        end
      end

      describe "Statitic" do
        context "words in month" do
          it {expect(user.words_in_month).to_not be_nil}
        end

        context "lessons in month" do
          it {expect(user.lesson_in_month).to_not be_nil}
        end

        context "categories in month" do
          it {expect(user.category_in_month).to_not be_nil}
        end
      end
    end
  end
end
