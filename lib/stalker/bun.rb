# frozen_string_literal: true

module Stalker
  class Bun
    def self.enabled?
      File.exist?('bun.lockb')
    end

    def self.version
      return unless enabled?

      { name: 'bun', dep_type: 'bun', version: `#{Stalker.configuration.bun_bin} -v`.strip }
    end

    def self.dependencies
      return unless enabled?

      JSON.parse(`cat package.json`).yield_self do |data|
        (data['dependencies'] || {}).merge(data['devDependencies'] || {})
      end.yield_self do |specs|
        `#{Stalker.configuration.bun_bin} pm ls`.lines.filter_map do |line|
          if line.strip =~ /^(├──|└──) (.+)@([\d.]+)$/
            _, name, version = Regexp.last_match.captures
            { name: name, dep_type: 'node_module', version: version } if specs.key?(name)
          end
        end
      end
    end
  end
end
