require "rails_helper"

RSpec.describe FollowsController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:another_user) {FactoryGirl.create :user}

  before {sign_in user}

  describe "#create" do
    it "follow another user" do
      put :create, followed_id: another_user.id, format: "js"
      expect(response).to render_template "follows/create"
    end
  end

  describe "#destroy" do
    before{user.follow another_user}
    it "unfollow another user" do
      delete :destroy, id: Follow.last.id, format: "js"
      expect(response).to render_template "follows/destroy"
    end
  end
end
