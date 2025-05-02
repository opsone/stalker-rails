# frozen_string_literal: true

module Stalker
  class Postgresql
    def self.enabled?
      ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
    rescue
      false
    end

    def self.version
      return unless enabled?

      version = ActiveRecord::Base.connection.select_value('SHOW server_version')

      { name: 'postgresql', dep_type: 'db_server', version: version }
    end
  end
end
