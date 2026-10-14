# frozen_string_literal: true

module Stalker
  class Sqlite
    def self.enabled?
      ActiveRecord::Base.connection_db_config.adapter == 'sqlite3'
    rescue
      false
    end

    def self.version
      return unless enabled?

      version = ActiveRecord::Base.connection_pool.with_connection { |connection| connection.select_value('SELECT sqlite_version()') }

      { name: 'sqlite', dep_type: 'db_server', version: version }
    end
  end
end
