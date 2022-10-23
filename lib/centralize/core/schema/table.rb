# frozen_string_literal: true

require_relative 'table/options'

module Centralize
  module Core
    module Schema
      class Table
        attr_reader :name, :options, :columns, :constraints, :indices

        def initialize(name, **options, &block)
          @name = name.to_sym
          @options = Options.new(**options)

          @columns = [].freeze
          @constraints = [].freeze
          @indices = [].freeze

          instance_eval(&block) if block
        end

        Column::Column.subclasses.each do |klass|
          define_method(klass.type) { |name, **options| column(name, klass.type, **options) }
        end

        def column(...)
          @columns = [*@columns, Column.new(...)].freeze
          self
        end

        def foreign_key; end
        def index; end
        def primary_key; end
      end
    end
  end
end
