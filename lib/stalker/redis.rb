# frozen_string_literal: true

module Stalker
  class Redis
    def self.enabled?
      !!Stalker.configuration.redis_url
    rescue
      false
    end

    def self.version
      return unless enabled?

      version = `#{Stalker.configuration.redis_bin} -u #{Stalker.configuration.redis_url} INFO SERVER`.yield_self do |info|
        info[/^redis_version:(\S+)/, 1]
      end

      { name: 'redis', dep_type: 'db_server', version: version }
    end
  end
end
