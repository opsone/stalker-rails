# frozen_string_literal: true

module Stalker
  class Npm
    def self.enabled?
      Rails.root.join('package-lock.json').exist?
    end

    def self.version
      return unless enabled?

      [
        NodePackages.node_version,
        { name: 'npm', dep_type: 'npm', version: Command.run(Stalker.configuration.npm_bin, '-v').strip }
      ]
    end

    def self.dependencies
      return unless enabled?

      NodePackages.parse(Command.run(Stalker.configuration.npm_bin, 'list', '--depth=0'))
    end
  end
end
