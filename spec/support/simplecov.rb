# frozen_string_literal: true

require 'simplecov'
require 'simplecov-console'
require 'simplecov_json_formatter'

SimpleCov.start do
  add_filter '/spec/'
  enable_coverage :branch
  formatter SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::JSONFormatter, # for codeclimate
      SimpleCov::Formatter::Console        # for stdout
    ]
  )
end
