require "rails_helper"

RSpec.describe WordsController, type: :controller do
  let(:user) {FactoryGirl.create :user}

  before {sign_in user}

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end
end
