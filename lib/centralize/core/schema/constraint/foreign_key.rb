# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      module Constraint
        class ForeignKey < Constraint
          def eql?
            false # TODO
          end
        end
      end
    end
  end
end
