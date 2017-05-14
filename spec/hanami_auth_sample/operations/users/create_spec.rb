require "spec_helper"

RSpec.describe Operations::Users::Create do
  let(:repository) { instance_double("UserRepository") }
  let(:user) { instance_double("User") }
  let(:name) { "tester" }
  let(:email) { "tester@example.com" }
  let(:params) { {name: name, email: email, password: "password"} }

  # This encrypted password was created from "password"
  let(:encrypted_password) { "$2a$06$wHLgEy5SxFZWiuZ5Xwnee.CrkV40CYTaCOqM8yDmoY6.xroUrE5Lq" }

  subject(:operation) { described_class.new(repository: repository) }

  before do
    allow(repository).to receive(:create).and_return(user)
  end

  it "creates a new user record" do
    expect(repository).to receive(:create) do |argument|
      aggregate_failures do
        expect(argument[:name]).to eq(params[:name])
        expect(argument[:email]).to eq(params[:email])
        expect(argument[:encrypted_password]).to match(/\$2a\$12\$.+/)
        expect(argument).not_to have_key :password
      end
    end

    subject.call(params)
  end
end
