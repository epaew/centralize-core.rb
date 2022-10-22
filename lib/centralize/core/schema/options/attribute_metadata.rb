# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      class Options
        class AttributeMetadata
          attr_reader :key, :default

          def initialize(key, default: nil, expects: Object, required: true)
            @key = key.to_sym

            @default = default
            @expects = Array(expects).freeze
            @required = required
          end

          def validate_attribute_value!(value)
            validate_attribute_value_presence!(value)
            validate_attribute_value_is_expected!(value)
          end

          private

          attr_reader :expects, :required

          def validate_attribute_value_is_expected!(value)
            return if value.nil?
            return if expects.any? { _1 === value } # rubocop:disable Style/CaseEquality

            raise ::TypeError,
                  "unexpected value is given for keyword: :#{key}. expected: #{expects.inspect}"
          end

          def validate_attribute_value_presence!(value)
            return if !value.nil? || !required

            raise ::ArgumentError, "missing keyword: :#{key}"
          end
        end
      end
    end
  end
end
