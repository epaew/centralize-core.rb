# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      # @abstract
      class Options
        include Core::Concerns::Attributes
        include Schema::Concerns::Comparable

        enable_comparable_with :attributes

        # @return [String]
        def to_dsl
          attributes
            .compact
            .map do |key, value|
              "#{key.inspect.delete_prefix(':')}: #{value.inspect}"
            end
            .join(', ')
        end
      end
    end
  end
end
