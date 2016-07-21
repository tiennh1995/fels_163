require "rails_helper"
require "cancan/matchers"

RSpec.describe "admin/answers/_answer.html.erb", type: :view do
  let(:answer){FactoryGirl.create :answer}
  let(:user){FactoryGirl.create :user}

  before do
    assign :user, user
    sign_in user
    render "admin/answers/answer", answer: answer
  end

  context "_answer" do
    it{expect(rendered).to include answer.title}
  end
end
