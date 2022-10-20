# frozen_string_literal: true

require_relative 'index/options'

module Centralize
  module Core
    module Schema
      class Index
        include Concerns::Comparable

        attr_reader :name, :options

        enable_comparable_with :name, :options

        def initialize(name, **options)
          @name = name.to_sym
          @options = Options.new(**options)
        end
      end
    end
  end
end
