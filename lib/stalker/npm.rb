# frozen_string_literal: true

module Stalker
  class Npm
    def self.enabled?
      File.exist?('package-lock.json')
    end

    def self.version
      return unless enabled?

      [
        { name: 'node', dep_type: 'node', version: `#{Stalker.configuration.node_bin} -v`.strip.delete_prefix('v') },
        { name: 'npm', dep_type: 'npm', version: `#{Stalker.configuration.npm_bin} -v`.strip }
      ]
    end

    def self.dependencies
      return unless enabled?

      JSON.parse(`cat package.json`).yield_self do |data|
        (data['dependencies'] || {}).merge(data['devDependencies'] || {})
      end.yield_self do |specs|
        `#{Stalker.configuration.npm_bin} list --depth=0`.lines.filter_map do |line|
          if line.strip =~ /^(├──|└──) (.+)@([\d.]+)$/
            _, name, version = Regexp.last_match.captures
            { name: name, dep_type: 'node_module', version: version } if specs.key?(name)
          end
        end
      end
    end
  end
end
