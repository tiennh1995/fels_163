require "rails_helper"
require "cancan/matchers"

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:admin){FactoryGirl.create :user, is_admin: true}
  let(:category){FactoryGirl.create :category}

  before{sign_in admin}

  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET /categories/:id" do
    it "renders the show template" do
      get :show, id: category.id
      expect(response).to render_template :show
    end
  end

  describe "GET /new" do
    it "renders the new template" do
      xhr :get, :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    before{allow(Category).to receive(:new).and_return category}

    context "when the category save successful" do
      before do
        allow(category).to receive(:save).and_return true
        post :create, category: {name: category.name}, format: "js"
      end
      it{expect(response).to redirect_to admin_categories_path}
    end

    context "when the category save fail" do
      before do
         allow(category).to receive(:save).and_return false
        post :create, category: {name: category.name}, format: "js"

      end
      it "renders the new template" do
        xhr :get, :new
        expect(response).to render_template :new
      end
    end
  end

  describe "DELETE categories/:id" do
      context "when the category destroy successfull" do
        before do
          delete :destroy, id: category.id
        end
        it{expect(response).to redirect_to admin_categories_path}
     end

     context "when the category destroy fail" do
        before do
          delete :destroy, id: category.id
        end
        it{expect(response).to redirect_to admin_categories_path}
     end
  end
end
