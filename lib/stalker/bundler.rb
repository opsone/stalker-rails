# frozen_string_literal: true

module Stalker
  class Bundler
    def self.version
      { name: 'bundler', dep_type: 'bundler', version: ::Bundler::VERSION }
    end

    def self.dependencies
      names = ::Bundler.load.dependencies.map(&:name)
      specs = ::Bundler.load.specs

      specs.filter_map do |spec|
        { name: spec.name, dep_type: 'ruby_gem', version: spec.version.to_s } if names.include?(spec.name)
      end
    end
  end
end
