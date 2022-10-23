# frozen_string_literal: true

RSpec.describe Centralize::Core::Concerns::Attributes::ClassMethods do
  let(:klass) do
    Class.new { extend Centralize::Core::Concerns::Attributes::ClassMethods }
  end
  let(:metadata_class) { Centralize::Core::Concerns::Attributes::Metadata }

  describe '.attribute' do
    def define_attribute(name, **options)
      klass.class_eval { attribute name, **options }
    end

    context 'when no attribute registered in klass' do
      let(:name) { Faker::Alphanumeric.alpha }

      context 'with no option' do
        let(:options) { {} }

        it 'registers new attribute_metadata' do
          expect { define_attribute(name, **options) }
            .to change { klass.attributes.count }.from(0).to(1)
          expect(klass.attributes).to match(
            name.to_sym => be_a(metadata_class).and(
              have_attributes(key: name.to_sym, default: nil, expects: [Object], required: true)
            )
          )
        end
      end

      context 'with options' do
        let(:options) do
          { default: Faker::Alphanumeric.alphanumeric, expects: String, required: false }
        end

        it 'registers new attribute_metadata' do
          expect { define_attribute(name, **options) }
            .to change { klass.attributes.count }.from(0).to(1)
          expect(klass.attributes).to match(
            name.to_sym =>
              have_attributes(key: name.to_sym, default: options[:default], expects: [String], required: false)
          )
        end
      end
    end

    context 'when some attribute registered in klass' do
      before do
        define_attribute(:key1)
        define_attribute(:key2)
      end

      let(:options) do
        { default: Faker::Alphanumeric.alphanumeric, expects: String, required: false }
      end

      context 'when the same name attribute has not registered' do
        let(:name) { :key3 }

        it 'registers new attribute_metadata' do
          expect { define_attribute(name, **options) }
            .to change { klass.attributes.count }.by(1)
          expect(klass.attributes).to match(
            key1: have_attributes(key: :key1, default: nil, expects: [Object], required: true),
            key2: have_attributes(key: :key2, default: nil, expects: [Object], required: true),
            key3: have_attributes(key: :key3, default: options[:default], expects: [String], required: false)
          )
        end
      end

      context 'when the same name attribute is already registered' do
        let(:name) { :key1 }

        it "overwrites key1's attribute_metadata" do
          expect { define_attribute(name, **options) }.not_to(change { klass.attributes.count })
          expect(klass.attributes).to match(
            key1: have_attributes(key: :key1, default: options[:default], expects: [String], required: false),
            key2: have_attributes(key: :key2, default: nil, expects: [Object], required: true)
          )
        end
      end
    end
  end

  describe '.inherited' do
    let(:superclass) do
      Class.new do
        extend Centralize::Core::Concerns::Attributes::ClassMethods

        attribute :key1
        attribute :key2
      end
    end
    let(:subclass) do
      Class.new(superclass) do
        attribute :key3
      end
    end

    it { expect(subclass.attribute_names).to contain_exactly(:key1, :key2, :key3) }
  end
end
