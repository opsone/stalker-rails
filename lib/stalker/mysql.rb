# frozen_string_literal: true

module Stalker
  class Mysql
    ADAPTERS = %w[mysql2 trilogy].freeze

    def self.enabled?
      ADAPTERS.include?(ActiveRecord::Base.connection_db_config.adapter)
    rescue
      false
    end

    def self.version
      return unless enabled?

      # MariaDB reports e.g. "10.11.6-MariaDB-0+deb12u1", MySQL e.g. "8.0.36" or "8.0.36-0ubuntu0.22.04.1"
      version = ActiveRecord::Base.connection_pool.with_connection { |connection| connection.select_value('SELECT VERSION()') }

      { name: version.match?(/mariadb/i) ? 'mariadb' : 'mysql', dep_type: 'db_server', version: version[/\A[\d.]+/] }
    end
  end
end
