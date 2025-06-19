# frozen_string_literal: true

require_relative 'lib/stalker/version'

Gem::Specification.new do |spec|
  spec.name        = 'stalker'
  spec.version     = Stalker::VERSION
  spec.authors     = ['Kevyn Lebouille']
  spec.email       = ['kevyn.lebouille@opsone.net']
  spec.homepage    = 'https://github.com/opsone/stalker-rails'
  spec.summary     = 'Summary of Stalker.'
  spec.description = 'Description of Stalker.'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage + '/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'rails', '>= 6.0.0'
  spec.add_dependency 'inifile', '3.0.0'
end
