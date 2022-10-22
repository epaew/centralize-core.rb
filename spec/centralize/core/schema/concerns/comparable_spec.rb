# frozen_string_literal: true

RSpec.describe Centralize::Core::Schema::Concerns::Comparable do
  describe '.enable_comparable_with' do
    context 'when string arguments are given' do
      let(:klass) do
        Class.new do
          include Centralize::Core::Schema::Concerns::Comparable

          enable_comparable_with 'key'
        end
      end

      it 'converts string arguments to symbol' do
        expect(klass._comparable_with).to contain_exactly(:class, :key)
      end
    end

    context 'when included multiple classes' do
      let(:klass) do
        Class.new do
          include Centralize::Core::Schema::Concerns::Comparable

          enable_comparable_with :key
        end
      end

      before do
        Class.new do
          include Centralize::Core::Schema::Concerns::Comparable

          enable_comparable_with :extra_key
        end
      end

      it 'does not share _comparable_with value with other class' do
        expect(klass._comparable_with).to contain_exactly(:class, :key)
      end
    end
  end

  describe '#eql?' do
    subject { object1.eql?(object2) }

    context 'when .enable_comparable_with has not been called' do
      let(:klass) do
        Struct.new(:key1, :key2, :key3) do
          include Centralize::Core::Schema::Concerns::Comparable
        end
      end

      context 'when all keys are same' do
        let(:object1) { klass.new(:a, :b, :c) }
        let(:object2) { klass.new(:a, :b, :c) }

        it { is_expected.to be true }
      end

      context 'when key1, key3 is same, key2 is not same' do
        let(:object1) { klass.new(:a, :b, :c) }
        let(:object2) { klass.new(:a, nil, :c) }

        it { is_expected.to be false }
      end

      context 'when key1, key2 is same, key3 is not same' do
        let(:object1) { klass.new(:a, :b, :c) }
        let(:object2) { klass.new(:a, :b) }

        it { is_expected.to be false }
      end
    end

    context 'when .enable_comparable_with has been called' do
      let(:klass) do
        Struct.new(:key1, :key2, :key3) do
          include Centralize::Core::Schema::Concerns::Comparable

          enable_comparable_with :key1, :key2
        end
      end

      context 'when all keys are same' do
        let(:object1) { klass.new(:a, :b, :c) }
        let(:object2) { klass.new(:a, :b, :c) }

        it { is_expected.to be true }
      end

      context 'when key1, key3 is same, key2 is not same' do
        let(:object1) { klass.new(:a, :b, :c) }
        let(:object2) { klass.new(:a, nil, :c) }

        it { is_expected.to be false }
      end

      context 'when key1, key2 is same, key3 is not same' do
        let(:object1) { klass.new(:a, :b, :c) }
        let(:object2) { klass.new(:a, :b) }

        it { is_expected.to be true }
      end
    end
  end

  describe '#hash' do
    subject { object.hash }

    let(:object) { klass.new(:a, :b, :c) }

    context 'when .enable_comparable_with has not been called' do
      let(:klass) do
        Struct.new(:key1, :key2, :key3) do
          include Centralize::Core::Schema::Concerns::Comparable
        end
      end

      it do
        expect(subject)
          .not_to eq([object.class.hash, object.key1.hash, object.key2.hash].inject(:^))
      end
    end

    context 'when .enable_comparable_with has been called' do
      let(:klass) do
        Struct.new(:key1, :key2, :key3) do
          include Centralize::Core::Schema::Concerns::Comparable

          enable_comparable_with :key1, :key2
        end
      end

      it do
        expect(subject)
          .to eq([object.class.hash, object.key1.hash, object.key2.hash].inject(:^))
      end
    end
  end
end
