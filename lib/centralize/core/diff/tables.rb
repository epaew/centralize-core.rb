# frozen_string_literal: true

module Centralize
  module Core
    module Diff
      class Tables
        attr_reader :added, :changed, :removed

        def initialize(new, current)
          new = new.to_h { |table| [table.name, table] }
          current = current.to_h { |table| [table.name, table] }

          @added = added_tables(new, current).freeze
          @changed = changed_tables(new, current).freeze
          @removed = removed_tables(new, current).freeze
        end

        private

        def added_tables(new, current)
          (new.keys - current.keys).map { Diff::Table.new(new[_1], nil) }
        end

        def changed_tables(new, current)
          (new.keys & current.keys)
            .map { Diff::Table.new(new[_1], current[_1]) }
            .select(&:changed?)
        end

        def removed_tables(new, current)
          (current.keys - new.keys).map { Diff::Table.new(nil, current[_1]) }
        end
      end
    end
  end
end
