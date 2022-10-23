# frozen_string_literal: true

RSpec.describe Centralize::Core::Concerns::Attributes::Metadata do
  describe '.validate_attribute_value!' do
    subject { metadata.validate_attribute_value!(value) }

    let(:metadata) do
      described_class.new(key, **metadata_options)
    end
    let(:metadata_options) do
      { default: default, expects: expects, required: required }.compact
    end

    let(:key) { :key }
    let(:default) { 'default value' }

    context 'with required: true' do
      let(:required) { true }

      context 'with expects: any object' do
        let(:expects) { nil }

        context 'with nil value' do
          let(:value) { nil }

          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context 'with non nil value' do
          let(:value) { [0, :symbol, 'string', true, false].sample }

          it { expect { subject }.not_to raise_error }
        end
      end

      context 'with expects: specific object' do
        let(:expects) { Integer }

        context 'with nil value' do
          let(:value) { nil }

          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context 'with non nil, non integer value' do
          let(:value) { [:symbol, 'string', true, false].sample }

          it { expect { subject }.to raise_error(TypeError) }
        end

        context 'with integer value' do
          let(:value) { 0 }

          it { expect { subject }.not_to raise_error }
        end
      end

      context 'with expects: specific objects' do
        let(:expects) { [true, false] }

        context 'with nil value' do
          let(:value) { nil }

          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context 'with non nil, non boolean value' do
          let(:value) { [0, :symbol, 'string'].sample }

          it { expect { subject }.to raise_error(TypeError) }
        end

        context 'with boolean value' do
          let(:value) { [true, false].sample }

          it { expect { subject }.not_to raise_error }
        end
      end

      context 'with expects: specific regexp' do
        let(:expects) { /string/ }

        context 'with nil value' do
          let(:value) { nil }

          it { expect { subject }.to raise_error(ArgumentError) }
        end

        context 'with string value not match' do
          let(:value) { 'str' }

          it { expect { subject }.to raise_error(TypeError) }
        end

        context 'with string value matches' do
          let(:value) { 'string' }

          it { expect { subject }.not_to raise_error }
        end
      end
    end

    context 'with required: false' do
      let(:required) { false }

      context 'with expects: any object' do
        let(:expects) { nil }

        context 'with any value' do
          let(:value) { [nil, 0, :symbol, 'string', true, false].sample }

          it { expect { subject }.not_to raise_error }
        end
      end

      context 'with expects: specific object' do
        let(:expects) { Integer }

        context 'with non nil, non integer value' do
          let(:value) { [:symbol, 'string', true, false].sample }

          it { expect { subject }.to raise_error(TypeError) }
        end

        context 'with nil, integer value' do
          let(:value) { [nil, 0].sample }

          it { expect { subject }.not_to raise_error }
        end
      end

      context 'with expects: specific objects' do
        let(:expects) { [true, false] }

        context 'with non nil, non boolean value' do
          let(:value) { [0, :symbol, 'string'].sample }

          it { expect { subject }.to raise_error(TypeError) }
        end

        context 'with nil, boolean value' do
          let(:value) { [nil, true, false].sample }

          it { expect { subject }.not_to raise_error }
        end
      end

      context 'with expects: specific regexp' do
        let(:expects) { /string/ }

        context 'with string value not match' do
          let(:value) { [0, :symbol, 'str', true, false].sample }

          it { expect { subject }.to raise_error(TypeError) }
        end

        context 'with nil, string value matches' do
          let(:value) { [nil, 'string'].sample }

          it { expect { subject }.not_to raise_error }
        end
      end
    end
  end
end
