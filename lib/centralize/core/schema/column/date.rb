# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      module Column
        # @!attribute [r] default
        #   @return [String, Date] The column's default literal value
        #   @return [nil] The column has no default value
        define_column_class(:date) do |klass|
          klass::Options.class_eval do
            attribute :default, expects: [::String, ::Date], required: false
          end
        end
      end
    end
  end
end
