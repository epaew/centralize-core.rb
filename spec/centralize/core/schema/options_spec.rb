# frozen_string_literal: true

RSpec.describe Centralize::Core::Schema::Options do
  describe '._comparable_with' do
    subject { described_class._comparable_with }

    it { is_expected.to contain_exactly(:class, :attributes) }
  end

  describe '.attribute' do
    subject { klass.new(**kwargs) }

    context 'with no option' do
      let(:klass) do
        Class.new(described_class) do
          attribute :key
        end
      end

      context 'with empty kwargs' do
        let(:kwargs) { {} }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context 'with key: nil' do
        let(:kwargs) { { key: nil } }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context 'with key: :symbol' do
        let(:kwargs) { { key: :symbol } }

        it do
          expect(subject)
            .to be_a(klass)
            .and have_attributes(kwargs)
        end
      end

      context 'with extra kwargs' do
        let(:kwargs) { { key: :symbol, key2: :symbol2 } }

        it do
          expect(subject)
            .to be_a(klass)
            .and have_attributes(kwargs.slice(:key))
        end
      end
    end

    context 'with :default option' do
      let(:klass) do
        Class.new(described_class) do
          attribute :key, default: :default_value
        end
      end

      context 'with empty kwargs' do
        let(:kwargs) { {} }

        it do
          expect(subject)
            .to be_a(klass)
            .and have_attributes(key: :default_value)
        end
      end

      context 'with key: nil' do
        let(:kwargs) { { key: nil } }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context 'with key: "string"' do
        let(:kwargs) { { key: 'string' } }

        it do
          expect(subject)
            .to be_a(klass)
            .and have_attributes(kwargs)
        end
      end
    end

    context 'with :expects option',  skip: 'tested in attribute_metadata_spec.rb'
    context 'with :required option', skip: 'tested in attribute_metadata_spec.rb'
  end

  describe '.inherited' do
    subject { subklass.new(a: :a) }

    let(:superklass) do
      Class.new(described_class) do
        attribute :a
        attribute :b, required: false
      end
    end
    let(:subklass) do
      Class.new(superklass) do
        attribute :c, default: :c
      end
    end

    it do
      expect(subject)
        .to be_a(subklass)
        .and have_attributes(a: :a, b: nil, c: :c)
    end
  end

  describe '#attributes' do
    subject { klass.new(a: :a).attributes }

    let(:klass) do
      Class.new(described_class) do
        attribute :a
        attribute :b, required: false
        attribute :c, default: :c
      end
    end

    it do
      expect(subject)
        .to be_a(Hash)
        .and eq({ a: :a, b: nil, c: :c })
    end
  end

  describe '#to_dsl' do
    subject { klass.new.to_dsl }

    let(:klass) do
      Class.new(described_class) do
        attribute :nil, required: false
        attribute :boolean, default: true
        attribute :integer, default: 0
        attribute :float, default: 0.0
        attribute :string, default: 'string'
        attribute :symbol, default: :symbol
      end
    end

    it { is_expected.to eq 'boolean: true, integer: 0, float: 0.0, string: "string", symbol: :symbol' }
  end
end
