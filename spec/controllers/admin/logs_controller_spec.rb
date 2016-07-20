require 'rails_helper'

RSpec.describe Admin::LogsController, type: :controller do
  let(:admin){FactoryGirl.create :user, is_admin: true}

  before{sign_in admin}

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
