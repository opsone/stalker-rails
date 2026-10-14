# frozen_string_literal: true

require 'json'

module Stalker
  # Shared by the npm, Yarn v1 and Bun probes, which all print a dependency tree
  module NodePackages
    # npm falls back to an ASCII tree (+-- / `--) when the locale is not UTF-8, which is common under systemd.
    # The version must start with a digit: skips ranges printed for unmet dependencies, keeps prereleases (8.0.0-beta.1)
    TREE_LINE = /\A(?:[├└]─+|[+`]--) (\S+)@(\d\S*)/

    def self.node_version
      { name: 'node', dep_type: 'node', version: Command.run(Stalker.configuration.node_bin, '-v').strip.delete_prefix('v') }
    end

    # Keeps only the packages declared in package.json, not their own dependencies
    def self.parse(tree)
      package = JSON.parse(Rails.root.join('package.json').read)
      declared = (package['dependencies'] || {}).merge(package['devDependencies'] || {})

      tree.each_line.filter_map do |line|
        match = line.strip.match(TREE_LINE)
        next unless match && declared.key?(match[1])

        { name: match[1], dep_type: 'node_module', version: match[2] }
      end
    end
  end
end
