# frozen_string_literal: true

RSpec.describe Centralize::Core::Schema::Column::Column::Options do
  describe '#initialize' do
    subject { described_class.new(**kwargs) }

    context 'when no kwargs are specified' do
      let(:kwargs) { {} }

      it do
        expect(subject)
          .to be_a(described_class)
          .and have_attributes(default: nil, default_function: nil, null: true, comment: nil)
      end
    end

    context 'when :default and :default_function are specified' do
      let(:kwargs) { { default: 'default', default_function: 'default_function' } }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end
end
