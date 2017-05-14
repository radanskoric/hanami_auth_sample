require "spec_helper"
require_relative "../../../../apps/web/controllers/session/new"

RSpec.describe Web::Controllers::Session::New do
  let(:action) { described_class.new }
  let(:params) { {} }

  context "when used normally" do
    it "is successful" do
      response = action.call(params)
      expect(response[0]).to eq 200
    end
  end

  context "when used after failed log in attempt" do
    let(:failure_message) { "Log In Failed" }
    let(:action) { described_class.new(login_failed_with: failure_message) }

    it "is responds with forbidden status" do
      response = action.call(params)
      expect(response[0]).to eq 403
    end

    it "is exposes the failure message" do
      action.call(params)
      expect(action.exposures[:failure_message]).to eq failure_message
    end
  end
end
