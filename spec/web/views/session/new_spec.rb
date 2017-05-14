require "spec_helper"
require_relative "../../../../apps/web/views/session/new"

RSpec.describe Web::Views::Session::New do
  let(:exposures) { {params: {}, failure_message: nil} }
  let(:template)  { Hanami::View::Template.new("apps/web/templates/session/new.html.slim") }
  let(:view)      { described_class.new(template, exposures) }

  describe "#render" do
    subject(:rendered) { view.render }

    it "renders a log in form" do
      aggregate_failures do
        expect(subject).to include "Log into the game"
        expect(subject).to match(%r{<form action=".+" .*method="POST".+>.+</form>}m)
      end
    end

    context "when exposures contain a failure message" do
      let(:message) { "A failure message" }
      let(:exposures) { {params: {}, failure_message: message} }

      it "renders the message" do
        expect(subject).to include message
      end
    end
  end

  describe "#form" do
    subject { view.form.to_s }

    it "renders correct fields" do
      %w[Email Password].each do |field|
        expect(subject).to include field
      end
    end

    it { is_expected.to match(/Log in/) }
  end
end
