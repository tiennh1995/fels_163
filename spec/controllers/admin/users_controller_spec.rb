require "rails_helper"
require "cancan/matchers"

RSpec.describe Admin::UsersController, type: :controller do
  let(:user){FactoryGirl.create :user}
  let(:admin){FactoryGirl.create :user, is_admin: true}

  before{sign_in admin}

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "DELETE /users/:id" do
    context "when user destroy successful" do
      before do
        delete :destroy, id: user.id
      end
      it{expect(response).to redirect_to admin_users_path}
    end

    context "when user destroy fail" do
      before do
        delete :destroy, id: user.id
      end
      it{expect(response).to redirect_to admin_users_path}
    end
  end

  describe "GET /users/:id" do
    it "renders the show template" do
      get :show, id: user.id
      expect(response).to render_template :show
    end
  end
end
