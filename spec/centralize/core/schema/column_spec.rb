# frozen_string_literal: true

RSpec.describe Centralize::Core::Schema::Column do
  describe '.new' do
    subject { described_class.new(name, type, **options) }

    let(:name) { Faker::Alphanumeric.alpha }
    let(:type) { :column }
    let(:options) do
      { default: Faker::String.random, comment: Faker::String.random }
    end

    it 'returns instance of Column::Column with specific attributes' do
      expect(subject)
        .to be_a(described_class::Column)
        .and have_attributes(
          name: name.to_sym,
          # type: :column, # NOTE: it raises NotImplementedError by default
          options: be_a(described_class::Column::Options).and(have_attributes(**options))
        )
    end
  end
end
