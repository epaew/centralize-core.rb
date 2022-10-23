# frozen_string_literal: true

module Centralize
  module Core
    module Diff
      class Table
        attr_reader :name, :options, :columns, :constraints, :indices

        # TODO
        def initilaize(new, current)
          @name = new&.name || current.name

          @options     = new&.options
          @columns     = Diff::Columns.new(new&.columns, current&.columns)
          @constraints = Diff::Constraints.new(new&.constraints, current&.constraints)
          @indices     = Diff::Indices.new(new&.indices, current&.indices)
        end

        def changed?; end
      end
    end
  end
end
