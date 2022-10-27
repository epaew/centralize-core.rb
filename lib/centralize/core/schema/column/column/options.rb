# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      module Column
        class Column
          # @!attribute [r] default
          #   @return The column's default literal value
          # @!attribute [r] default_function
          #   @return [String, nil] The SQL function to set column's default value
          # @!attribute [r] null
          #   @return [Boolean] whether the column can be null
          # @!attribute [r] comment
          #   @return [String, nil]
          class Options < Schema::Options
            attribute :default,          required: false
            attribute :default_function, expects: ::String, required: false
            attribute :null,             default: true,     expects: [true, false]
            attribute :comment,          expects: ::String, required: false

            # @param opts [Hash]
            # @return [self]
            def initialize(**opts)
              if opts.values_at(:default, :default_function).none?(&:nil?)
                raise ::ArgumentError, 'either :default or :default_function must be nil'
              end

              super(**opts)
            end
          end
        end
      end
    end
  end
end
