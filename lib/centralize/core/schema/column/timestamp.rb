# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      module Column
        # @!attribute [r] default
        #   @return [String, Time, DateTime] The column's default literal value
        #   @return [nil] The column has no default value
        # @!attribute [r] precision
        #   @return [Integer]
        #   @return [nil]
        define_column_class(:timestamp) do |klass|
          klass::Options.class_eval do
            attribute :default,   expects: [::String, ::Time, ::DateTime], required: false
            attribute :precision, expects: (0..6),                         required: false
          end
        end
      end
    end
  end
end
