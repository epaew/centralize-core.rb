# frozen_string_literal: true

module Centralize
  module Core
    module Schema
      class Database
        class Options < Schema::Options
          attribute :collation, expects: ::String, required: false
        end
      end
    end
  end
end
