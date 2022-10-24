# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      module Concerns
        module Comparable
          module ClassMethods
            attr_reader :_comparable_with

            private

            def enable_comparable_with(*keys)
              @_comparable_with = ::Set[:class, *keys.map(&:to_sym)].freeze
            end
          end

          def self.included(klass)
            klass.extend ClassMethods
          end

          def eql?(other)
            return super if _comparable_with.nil?

            _comparable_with.all? do |key|
              __send__(key).eql?(other.__send__(key))
            end
          end

          def hash
            return super if _comparable_with.nil?

            _comparable_with
              .map { |key| __send__(key).hash }
              .inject(:^)
          end

          private

          def _comparable_with
            self.class._comparable_with
          end
        end
      end
    end
  end
end
