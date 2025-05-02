# frozen_string_literal: true

module Stalker
  class Sqlite
    def self.enabled?
      ActiveRecord::Base.connection.adapter_name == 'SQLite'
    rescue
      false
    end

    def self.version
      return unless enabled?

      version = ActiveRecord::Base.connection.select_value('SELECT sqlite_version()')

      { name: 'sqlite', dep_type: 'db_server', version: version }
    end
  end
end
