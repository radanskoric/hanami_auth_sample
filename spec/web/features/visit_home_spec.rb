require "features_helper"

RSpec.describe "Visit home" do
  it "is successful" do
    visit "/"

    expect(page.body).to include("Welcome")
  end
end
