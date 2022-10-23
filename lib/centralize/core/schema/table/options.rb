# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      class Table
        # TODO
        #
        # @!attribute [r] comment
        #   @return [String, nil]
        # @!attribute [r] primary
        #   @return [Symbol, Array<Symbol>]
        # @!attribute [r] temporary
        #   @return [Boolean]
        class Options < Schema::Options
          attribute :primary_key, default: :id,      expects: [::Symbol, ::Array]
          attribute :temporary,   default: false,    expects: [true, false]
          attribute :comment,     expects: ::String, required: false
        end

        def initialize(**opts)
          opts[:primary_key] = opts[:primary_key].map(&:to_sym) if opts[:primary_key].is_a?(Enumerable)

          super(**opts)
        end
      end
    end
  end
end
