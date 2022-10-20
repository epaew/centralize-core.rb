# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      class Index
        class Options < Schema::Options
          attribute :column_names, expects: [Array]
          attribute :unique, default: false, expects: [true, false]

          def initialize(**opts)
            opts[:column_names] = Array(opts[:column_names]).map(&:to_sym)

            super(**opts)
          end
        end
      end
    end
  end
end
