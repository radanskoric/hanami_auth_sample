require "spec_helper"
require_relative "../../../../apps/web/controllers/users/create"

RSpec.describe Web::Controllers::Users::Create do
  let(:operation) { instance_double("Operations::Users::Create") }
  let(:user) { instance_double("User") }
  let(:valid_params) { {name: "tester", email: "tester@example.com", password: "password"} }

  subject(:action) { described_class.new(operation: operation) }

  before do
    allow(operation).to receive(:call).and_return(user)
  end

  describe "#call" do
    let(:warden) { instance_double("Warden::Proxy") }
    let(:params) { {:user => user_params, "warden" => warden} }
    let(:errors) { action.params.errors }

    subject { action.call(params) }

    before do
      allow(warden).to receive(:set_user).and_return(true)
    end

    context "with valid params" do
      let(:user_params) { valid_params }

      it "logs the user in" do
        expect(warden).to receive(:set_user).with(user)
        subject
      end

      it "redirects to home page" do
        expect(subject).to redirect_to "/"
      end

      it "creates a new user record" do
        expect(operation).to receive(:call).with(user_params)

        subject
      end
    end

    context "with missing name" do
      let(:user_params) { valid_params.merge(name: "") }

      it { is_expected.to have_http_status(:error) }

      it "stores the correct error" do
        subject
        expect(errors.dig(:user, :name)).to eq(["must be filled"])
      end
    end

    context "with missing email" do
      let(:user_params) { valid_params.merge(email: "") }

      it { is_expected.to have_http_status(:error) }

      it "stores the correct error" do
        subject
        expect(errors.dig(:user, :email)).to eq(["must be filled"])
      end
    end

    context "with invalid email" do
      let(:user_params) { valid_params.merge(email: "notanemail") }

      it { is_expected.to have_http_status(:error) }

      it "stores the correct error" do
        subject
        expect(errors.dig(:user, :email)).to eq(["is in invalid format"])
      end
    end

    context "with missing password" do
      let(:user_params) { valid_params.merge(password: "") }

      it { is_expected.to have_http_status(:error) }

      it "stores the correct error" do
        subject
        expect(errors.dig(:user, :password)).to include("must be filled")
      end
    end

    context "with a password that is too short" do
      let(:user_params) { valid_params.merge(password: "12345") }

      it { is_expected.to have_http_status(:error) }

      it "stores the correct error" do
        subject
        expect(errors.dig(:user, :password)).to eq(["length must be within 6 - 64"])
      end
    end
  end
end
