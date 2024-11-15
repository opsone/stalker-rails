# frozen_string_literal: true

require_relative "lib/stalker/version"

Gem::Specification.new do |spec|
  spec.name        = "stalker"
  spec.version     = Stalker::VERSION
  spec.authors     = [ "Kevyn Lebouille" ]
  spec.email       = [ "kevyn.lebouille@opsone.net" ]
  spec.homepage    = "https://gitlab.opsone.net"
  spec.summary     = "Summary of Stalker."
  spec.description = "Description of Stalker."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://gitlab.opsone.net"
  spec.metadata["changelog_uri"] = "https://gitlab.opsone.net"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.1.0"
end
