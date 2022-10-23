# frozen_string_literal: true

module Centralize
  module Core
    module Diff
      class Indices
        attr_reader :added, :removed

        # TODO: implement #eql? to Schema::Index
        def initialize(new, current)
          @added = (new - current).freeze
          @removed = (current - new).freeze
        end
      end
    end
  end
end
