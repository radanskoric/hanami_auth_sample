require_relative '../../../../apps/web/views/home/index'

RSpec.describe Web::Views::Home::Index do
  let(:exposures) { {} }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/home/index.html.slim') }
  let(:view)      { described_class.new(template, exposures) }

  subject(:rendered)  { view.render }

  it { is_expected.not_to be_empty }
end
