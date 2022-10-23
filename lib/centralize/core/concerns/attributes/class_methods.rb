# frozen_string_literal: true

module Centralize
  module Core
    module Concerns
      module Attributes
        module ClassMethods
          def inherited(subclass)
            super
            subclass.instance_variable_set(:@attributes, attributes)
          end

          def attributes
            @attributes ||= {}.freeze
          end

          def attribute_names
            attributes.keys
          end

          private

          def attribute(key, **metadata_options)
            key = key.to_sym
            attr_accessor key unless attribute_names.include?(key)

            # NOTE: overwrite with newer if key is duplicated
            metadata = Metadata.new(key, **metadata_options)
            @attributes = { **attributes, key => metadata }.freeze
          end
        end
      end
    end
  end
end
