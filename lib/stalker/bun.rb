# frozen_string_literal: true

module Stalker
  class Bun
    # bun.lock is the default text lockfile since Bun 1.2, bun.lockb the former binary one
    LOCKFILES = %w[bun.lock bun.lockb].freeze

    def self.enabled?
      LOCKFILES.any? { |lockfile| Rails.root.join(lockfile).exist? }
    end

    def self.version
      return unless enabled?

      { name: 'bun', dep_type: 'bun', version: Command.run(Stalker.configuration.bun_bin, '-v').strip }
    end

    def self.dependencies
      return unless enabled?

      NodePackages.parse(Command.run(Stalker.configuration.bun_bin, 'pm', 'ls'))
    end
  end
end
