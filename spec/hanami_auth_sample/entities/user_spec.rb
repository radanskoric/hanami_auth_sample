require "spec_helper"

RSpec.describe User do
  let(:password) { "password" }
  # This encrypted password was created from "password"
  let(:encrypted_password) { "$2a$06$wHLgEy5SxFZWiuZ5Xwnee.CrkV40CYTaCOqM8yDmoY6.xroUrE5Lq" }

  shared_examples "a user with 'password' for password" do
    subject { user.password }

    it { is_expected.to be_an_instance_of(BCrypt::Password) }

    it "is true when compared to correct original password value" do
      expect(subject).to eq password
    end

    it "is false when compared to invalid password value" do
      expect(subject).not_to eq "somethingelse"
    end
  end

  describe "#password" do
    let(:user) { described_class.new(encrypted_password: encrypted_password) }

    it_should_behave_like "a user with 'password' for password"
  end
end
