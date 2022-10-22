# frozen_string_literal: true

require_relative 'options/attribute_metadata'

module Centralize
  module Core
    module Schema
      class Options
        class << self
          def inherited(subclass)
            super
            subclass.instance_variable_set(:@attributes, attributes)
          end

          def attributes
            @attributes ||= {}.freeze
          end

          private

          def attribute(key, **metadata_options)
            key = key.to_sym
            attr_reader key

            # NOTE: overwrite with newer if key is duplicated
            metadata = AttributeMetadata.new(key, **metadata_options)
            @attributes = { **attributes, key => metadata }.freeze
          end
        end

        def initialize(**kwargs)
          self.class.attributes.each do |key, metadata|
            value = kwargs.fetch(key) { metadata.default }
            metadata.validate_attribute_value!(value)

            instance_variable_set(:"@#{key}", value)
          end
        end

        def attributes
          self.class.attributes.to_h do |key, _|
            [key, instance_variable_get(:"@#{key}")]
          end
        end
        alias to_h attributes
      end
    end
  end
end
