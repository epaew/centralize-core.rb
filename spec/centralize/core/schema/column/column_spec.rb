# frozen_string_literal: true

RSpec.describe Centralize::Core::Schema::Column::Column do
  describe '.inherited / .subclasses' do
    subject(:create_subclass) { Class.new(described_class) }

    it 'adds created subclass to described_class.subclasses' do
      expect { create_subclass }.to change(described_class, :subclasses)

      expect(described_class.subclasses).to include(create_subclass)
    end
  end

  describe '.type' do
    subject { described_class.type }

    it { expect { subject }.to raise_error NotImplementedError }
  end

  describe '#initialize' do
    subject { described_class.new(name, **options) }

    let(:name) { Faker::Alphanumeric.alpha }
    let(:options) do
      { default: Faker::String.random, comment: Faker::String.random }
    end

    it 'returns instance of described_class with specific attributes' do
      expect(subject)
        .to be_a(described_class)
        .and have_attributes(
          name: name.to_sym,
          # type: :column, # NOTE: it raises NotImplementedError by default
          options: be_a(described_class::Options).and(have_attributes(**options))
        )
    end
  end

  describe '#to_dsl' do
    subject { column.to_dsl }

    let(:column) { described_class.new(:column_name) }

    before do
      allow(described_class).to receive(:type).and_return(:abstract_column)
    end

    it { is_expected.to eq "t.abstract_column :column_name, #{column.options.to_dsl}" }
  end

  describe '#type' do
    subject { column.type }

    let(:column) { described_class.new(:column_name) }

    before do
      allow(described_class).to receive(:type).and_return(:abstract_column)
    end

    it 'returns .type of self class' do
      expect(subject).to eq :abstract_column
      expect(described_class).to have_received(:type).with(no_args)
    end
  end
end
