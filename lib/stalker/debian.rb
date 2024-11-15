# frozen_string_literal: true

module Stalker
  class Debian
    def self.version
      { name: 'debian', dep_type: 'os', version: `cat /etc/debian_version 2> /dev/null`.strip }
    end
  end
end
