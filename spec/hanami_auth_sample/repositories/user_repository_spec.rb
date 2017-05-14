require "spec_helper"

RSpec.describe UserRepository do
  subject(:repository) { described_class.new }

  describe "#find_by_email" do
    let(:email) { "tester@example.com" }
    subject { repository.find_by_email(email) }

    context "when there is a user with the email" do
      let!(:user) { repository.create(email: email, name: "tester") }

      it { is_expected.to eq(user) }
    end

    context "when there is no user" do
      it { is_expected.to be_nil }
    end

    context "when there is a user with a different email" do
      let!(:user) { repository.create(email: "wrong@example.com", name: "tester") }

      it { is_expected.to be_nil }
    end
  end

  describe "#authenticate" do
    let(:email) { "tester@example.com" }
    let(:password) { "password" }
    subject { repository.authenticate(email, password) }

    context "when there is a user with the email" do
      let(:create_operation) { Operations::Users::Create.new(repository: repository) }

      before { user }

      def create_with(password:)
        create_operation.call(email: email, name: "tester", password: password)
      end

      context "when the password matches" do
        let!(:user) { create_with(password: password) }

        it { is_expected.to eq(user) }
      end

      context "when the password doesn't match" do
        let(:user) { create_with(password: "something") }

        it { is_expected.to be_nil }
      end
    end

    context "when there is no user with the email" do
      it { is_expected.to be_nil }
    end
  end
end
