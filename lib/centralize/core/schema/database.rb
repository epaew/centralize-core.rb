# frozen_string_literal: true

require_relative 'database/options'

module Centralize
  module Core
    module Schema
      class Database
        attr_reader :name, :options, :tables

        def initialize(name, **options, &block)
          @name = name.to_sym
          @options = Options.new(**options)

          @tables = [].freeze

          instance_eval(&block) if block
        end

        def create_table(name, **options)
          @tables = [*@tables, Table.new(name: name.to_sym, **options)].freeze
          self
        end
      end
    end
  end
end
