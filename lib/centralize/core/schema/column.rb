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

          # @param name [Symbol, String] The name of subclass of Column::Column
          # @yield [klass]
          # @yieldparam klass [Column::Column]
          def define_column_class(name, &block)
            name = name.to_s
            column_class = create_column_subclass(type: name.underscore)
            options_class = create_column_options_subclass

            const_set(name.camelize, column_class)
            column_class.const_set(:Options, options_class)

            column_class.class_eval(&block) if block
          end

          private

          def create_column_subclass(type:)
            type = type.to_sym

            Class.new(self::Column) do
              define_singleton_method(:type) { type }
            end
          end

          def create_column_options_subclass
            Class.new(self::Column::Options)
          end
        end
      end
    end
  end
end

require_relative 'column/smallint'
require_relative 'column/integer'
require_relative 'column/bigint'

require_relative 'column/decimal'
require_relative 'column/numeric'

require_relative 'column/float'

require_relative 'column/boolean'

require_relative 'column/date'
require_relative 'column/time'
require_relative 'column/timestamp'
