# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      class Options
        include Core::Concerns::Attributes
        include Schema::Concerns::Comparable

        enable_comparable_with :attributes
      end
    end
  end
end
