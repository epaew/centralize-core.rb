# frozen_string_literal: true

require_relative 'attributes/class_methods'
require_relative 'attributes/metadata'

module Centralize
  module Core
    module Concerns
      module Attributes
        def self.included(klass)
          klass.extend ClassMethods
        end

        def initialize(**kwargs)
          self.class.attributes.each do |attribute_name, metadata|
            value = kwargs.fetch(attribute_name) { metadata.default }
            metadata.validate_attribute_value!(value)

            public_send(:"#{attribute_name}=", value)
          end
        end

        def attributes
          self.class.attribute_names.to_h do |name|
            [name, public_send(name)]
          end
        end
        alias to_h attributes
      end
    end
  end
end
