# frozen_string_literal: true

module Stalker
  class Postgresql
    def self.enabled?
      ActiveRecord::Base.connection_db_config.adapter == 'postgresql'
    rescue
      false
    end

    def self.version
      return unless enabled?

      version = ActiveRecord::Base.connection_pool.with_connection do |connection|
        connection.select_value("SELECT split_part(current_setting('server_version'), ' ', 1)")
      end

      { name: 'postgresql', dep_type: 'db_server', version: version }
    end
  end
end
