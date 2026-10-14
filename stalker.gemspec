# frozen_string_literal: true

require_relative 'lib/stalker/version'

Gem::Specification.new do |spec|
  spec.name        = 'stalker'
  spec.version     = Stalker::VERSION
  spec.authors     = ['Kevyn Lebouille']
  spec.email       = ['kevyn.lebouille@opsone.net']
  spec.homepage    = 'https://github.com/opsone/stalker-rails'
  spec.summary     = 'Exposes the versions of a Rails application runtime dependencies for monitoring.'
  spec.description = 'Rails engine serving a JSON endpoint with the versions of the OS, database, Redis, search servers, Ruby, gems and Node packages an application runs on.'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage + '/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'CHANGELOG.md', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.required_ruby_version = '>= 3.3.0'

  spec.add_dependency 'actionpack', '>= 7.0'
  spec.add_dependency 'activerecord', '>= 7.0'
  spec.add_dependency 'activesupport', '>= 7.0'
  spec.add_dependency 'railties', '>= 7.0'
end
