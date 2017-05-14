require "features_helper"

RSpec.describe "Log into the application" do
  let(:name) { "Tester" }
  let(:email) { "tester@example.com" }
  let(:password) { "password" }
  let(:user_create_operation) { Operations::Users::Create.new }

  before do
    user_create_operation.call(email: email, name: name, password: password)

    visit "/session/new"
  end

  def log_in_with(login_email, login_password)
    fill_in "Email", with: login_email
    fill_in "Password", with: login_password

    click_button "Log in"
  end

  context "with correct credentials" do
    before { log_in_with(email, password) }

    it "logs the user in and allows log out" do
      expect(page.body).to include("Tester")

      click_button "Log Out"

      expect(page.body).not_to include("Tester")
    end
  end

  context "with incorrect email" do
    before { log_in_with("wrong_email@example.com", password) }

    it "shows an error and allows second login attempt" do
      expect(page.body).to include("Invalid user name or password")

      log_in_with(email, password)
    end
  end

  context "with incorrect password" do
    before { log_in_with(email, "wrongpassword") }

    it "shows an error and allows second login attempt" do
      expect(page.body).to include("Invalid user name or password")

      log_in_with(email, password)
    end
  end
end
