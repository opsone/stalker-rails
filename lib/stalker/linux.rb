# frozen_string_literal: true

module Stalker
  class Linux
    def self.enabled?
      File.exist?('/etc/os-release')
    end

    def self.version
      return unless enabled?

      ini = IniFile.load('/etc/os-release', comment: '#', default: 'os', parameter: '=')

      { name: ini['os']['ID'], dep_type: 'os', version: ini['os']['VERSION_ID'] }
    end
  end
end
