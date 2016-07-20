require "rails_helper"
require "cancan/matchers"

RSpec.describe Admin::ActivitiesController, type: :controller do
  let(:admin){FactoryGirl.create :user, is_admin: true}

  before{sign_in admin}

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
