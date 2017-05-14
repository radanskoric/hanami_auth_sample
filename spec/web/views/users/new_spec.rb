require "spec_helper"
require_relative "../../../../apps/web/views/users/new"

RSpec.describe Web::Views::Users::New do
  let(:params)    { OpenStruct.new(valid?: true) }
  let(:exposures) { {params: params} }
  let(:template)  { Hanami::View::Template.new("apps/web/templates/users/new.html.slim") }
  let(:view)      { described_class.new(template, exposures) }

  subject(:rendered) { view.render }

  it "renders a registration form" do
    aggregate_failures do
      expect(subject).to include "Create a new account"
      expect(subject).to match(%r{<form action=".+" .*method="POST".+>.+</form>}m)
    end
  end

  describe "#form" do
    subject { view.form.to_s }

    it "renders correct fields" do
      %w[Name Email Password].each do |field|
        expect(subject).to include field
      end
    end

    it { is_expected.to match(/Register/) }

    context "when there are errors" do
      let(:params) { OpenStruct.new(valid?: false, errors: {user: user_errors}) }

      %i[name email password].each do |field|
        context "on #{field}" do
          let(:user_errors) { {field => ["must be filled"]} }

          it { is_expected.to include("#{field.capitalize} must be filled") }
        end
      end
    end
  end
end
