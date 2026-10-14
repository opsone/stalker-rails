# frozen_string_literal: true

module Stalker
  class Yarn
    def self.enabled?
      Rails.root.join('yarn.lock').exist?
    end

    def self.version
      return unless enabled?

      [
        NodePackages.node_version,
        { name: 'yarn', dep_type: 'yarn', version: Command.run(Stalker.configuration.yarn_bin, '-v').strip }
      ]
    end

    # Yarn v1 only: Yarn 2+ has no list command
    def self.dependencies
      return unless enabled?

      NodePackages.parse(Command.run(Stalker.configuration.yarn_bin, 'list', '--depth=0'))
    end
  end
end
