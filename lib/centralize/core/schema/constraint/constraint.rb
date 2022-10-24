# frozen_string_literal: true

require_relative 'constraint/options'

module Centralize
  module Core
    module Schema
      module Constraint
        class Constraint
          attr_reader :name, :options

          class << self
            def type
              raise NotImplementedError
            end
          end

          def initialize(name, **options)
            @name = name.to_sym
            # NOTE: initialize subclass's options if defined
            @options = self.class::Options.new(**options)
          end

          def type
            self.class.type
          end
        end
      end
    end
  end
end
