# frozen_string_literal: true

RSpec.describe Centralize::Core::Concerns::Attributes do
  describe '#attributes' do
    subject { klass.new(a: :a).attributes }

    let(:klass) do
      Class.new do
        include Centralize::Core::Concerns::Attributes

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
end
