# frozen_string_literal: true

require_relative 'constraint/constraint'

require_relative 'constraint/foreign_key'
require_relative 'constraint/primary_key'
require_relative 'constraint/unique'

module Centralize
  module Core
    module Schema
      module Constraint
        class << self
          def new(name, type, **options)
            const_get(type.to_s.camelize, false).new(name, **options)
          end
        end
      end
    end
  end
end
