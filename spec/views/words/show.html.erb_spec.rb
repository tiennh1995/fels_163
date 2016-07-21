require "rails_helper"
require "cancan/matchers"

RSpec.describe "words/show.html.erb", type: :view do
  let(:word){FactoryGirl.create :word,
    answers: FactoryGirl.create_list(:answer, 2)}
  let(:user){FactoryGirl.create :user}

  before do
    assign :user, user
    sign_in user
    assign :word, word
    render
  end

  it do
    expect(controller.request.path_parameters[:controller]).to eq "words"
    expect(controller.request.path_parameters[:action]).to eq "show"
  end

  context "render" do
    it "words show" do
      expect(rendered).to render_template("words/_word")
    end

    it "template index answers" do
      expect(rendered).to render_template("shared/_word_answers")
    end
  end
end
