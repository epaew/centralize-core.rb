# frozen_string_literal: true

RSpec.describe Centralize::Core::Schema::Index do
  describe '._comparable_with' do
    subject { described_class._comparable_with }

    it { is_expected.to contain_exactly(:class, :name, :options) }
  end
end
