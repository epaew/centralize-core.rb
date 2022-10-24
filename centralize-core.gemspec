# frozen_string_literal: true

require_relative 'lib/centralize/core/version'

Gem::Specification.new do |spec|
  spec.name                  = 'centralize-core'
  spec.version               = Centralize::Core::VERSION
  spec.authors               = ['epaew']
  spec.email                 = ['epaew.333@gmail.com']

  spec.summary               = '' # TODO
  spec.description           = spec.summary
  spec.homepage              = 'https://github.com/epaew/centralize-core.rb'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/epaew/centralize-core.rb'
  spec.metadata['changelog_uri']   = 'https://github.com/epaew/centralize-core.rb/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 6.0'
end
