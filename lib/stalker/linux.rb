# frozen_string_literal: true

require 'inifile'

module Stalker
  class Linux
    def self.enabled?
      File.exist?('/etc/os-release')
    end

    def self.version
      return unless enabled?

      if File.exist?('/etc/debian_version')
        version = `cat /etc/debian_version`.strip

        { name: 'debian', dep_type: 'os', version: version }
      else
        ini = IniFile.load('/etc/os-release', comment: '#', default: 'os', parameter: '=')

        { name: ini['os']['ID'], dep_type: 'os', version: ini['os']['VERSION_ID'] }
      end
    end
  end
end
