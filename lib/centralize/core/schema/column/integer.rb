# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      module Column
        # @!attribute [r] default
        #   @return [Integer] The column's default literal value
        #   @return [nil] The column has no default value
        define_column_class(:integer) do |klass|
          klass::Options.class_eval do
            attribute :default, expects: ::Integer, required: false
          end
        end
      end
    end
  end
end
