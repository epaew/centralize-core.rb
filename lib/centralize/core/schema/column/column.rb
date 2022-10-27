# frozen_string_literal: true

require_relative 'column/options'

module Centralize
  module Core
    module Schema
      module Column
        # @abstract
        # @!attribute [r] name
        #   @return [Symbol]
        # @!attribute [r] options
        #   @return [Column::Options]
        class Column
          attr_reader :name, :options

          class << self
            # @return [Set<Column::Column>]
            def subclasses
              @subclasses ||= ::Set[].freeze
            end

            # @abstract
            # @return [Symbol]
            def type
              raise NotImplementedError
            end

            private

            def inherited(subclass)
              super
              @subclasses = ::Set[*subclasses, subclass].freeze
            end
          end

          # @param name [Symbol, String]
          # @param options [Hash]
          # @return [self]
          def initialize(name, **options)
            @name = name.to_sym
            # NOTE: initialize subclass's options if defined
            @options = self.class::Options.new(**options)
          end

          # @return [String]
          def to_dsl
            "t.#{type} #{name.inspect}, #{options.to_dsl}"
          end

          # @return [Symbol]
          def type
            self.class.type
          end
        end
      end
    end
  end
end
