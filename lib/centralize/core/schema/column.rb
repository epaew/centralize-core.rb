# frozen_string_literal: true

require_relative 'column/column'

module Centralize
  module Core
    module Schema
      module Column
        class << self
          # @param name [Symbol, String]
          # @param type [Symbol, String]
          # @param options [Hash]
          # @return [Column::Column] An instance of a subclass of Column::Column
          def new(name, type, **options)
            const_get(type.to_s.camelize, false).new(name, **options)
          end
        end
      end
    end
  end
end
