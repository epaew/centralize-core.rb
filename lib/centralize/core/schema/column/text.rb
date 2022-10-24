# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      module Column
        define_column_class(:text) do |klass|
          klass::Options.class_eval do
            attribute :collation, expects: ::String,  required: false
            attribute :default,   expects: ::String,  required: false
            attribute :limit,     expects: ::Integer, required: false
          end
        end
      end
    end
  end
end
