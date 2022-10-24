# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      module Column
        # @!attribute [r] default
        #   @return [Float] The column's default literal value
        #   @return [nil] The column has no default value
        # @!attribute [r] precision
        #   @return [Integer]
        #   @return [nil]
        # @!attribute [r] scale
        #   @return [Integer]
        #   @return [nil]
        define_column_class(:numeric) do |klass|
          klass::Options.class_eval do
            attribute :default,   expects: ::Float,   required: false
            attribute :precision, expects: ::Integer, required: false
            attribute :scale,     expects: ::Integer, required: false
          end
        end
      end
    end
  end
end
