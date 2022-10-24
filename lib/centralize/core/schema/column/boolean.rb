# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      module Column
        define_column_class(:boolean)

        class Boolean
          # @!attribute [r] default
          #   @return [Boolean] The column's default literal value
          #   @return [nil] The column has no default value
          class Options
            attribute :default, default: false, expects: [true, false], required: false
          end
        end
      end
    end
  end
end
