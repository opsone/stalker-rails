# frozen_string_literal: true

module Stalker
  class Mysql
    def self.enabled?
      ActiveRecord::Base.connection.adapter_name == 'Mysql2'
    rescue
      false
    end

    def self.version
      return unless enabled?

      version = ActiveRecord::Base.connection.select_value('SELECT VERSION()')

      { name: 'mysql', dep_type: 'db_server', version: version }
    end
  end
end
