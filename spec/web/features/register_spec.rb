require "features_helper"

RSpec.describe "Register as a new user" do
  let(:name) { "Tester" }
  let(:email) { "tester@example.com" }
  let(:password) { "password" }
  let(:user_repository) { UserRepository.new }

  before do
    expect(user_repository.find_by_email(email)).to be_nil

    visit "/users/new"

    expect(page.body).to include("Create a new account")
  end

  def fill_in_correct_values
    fill_in "Name", with: name
    fill_in "Email", with: email
    fill_in "Password", with: password
  end

  specify "with valid params creates a new user" do
    fill_in_correct_values

    click_button "Register"

    new_user = user_repository.find_by_email(email)
    expect(new_user).not_to be_nil
    aggregate_failures do
      expect(new_user.email).to eq(email)
      expect(new_user.password).to eq(password)
    end

    expect(page.body).to include(name)

    click_button "Log Out"
  end

  specify "with invalid params shows error messages" do
    fill_in "Name", with: ""
    fill_in "Email", with: "not an email"
    fill_in "Password", with: ""

    click_button "Register"

    expect(user_repository.find_by_email(email)).to be_nil

    expect(page.body).not_to include(name)
    expect(page.body).to include("Name must be filled")
    expect(page.body).to include("Password must be filled")
    expect(page.body).to include("Email is in invalid format")
  end
end
