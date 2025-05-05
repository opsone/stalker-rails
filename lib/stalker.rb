# frozen_string_literal: true

require 'stalker/bun'
require 'stalker/bundler'
require 'stalker/elasticsearch'
require 'stalker/engine'
require 'stalker/linux'
require 'stalker/meilisearch'
require 'stalker/mysql'
require 'stalker/npm'
require 'stalker/postgresql'
require 'stalker/redis'
require 'stalker/ruby'
require 'stalker/sqlite'
require 'stalker/version'
require 'stalker/yarn'

module Stalker
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

  class Configuration
    attr_accessor :client_ip_header, :access_token, :node_bin, :npm_bin, :yarn_bin, :bun_bin, :redis_bin, :elasticsearch_url, :meilisearch_url, :redis_url

    def initialize
      @access_token = false
      @node_bin = 'node'
      @npm_bin = 'npm'
      @yarn_bin = 'yarn'
      @bun_bin = 'bun'
      @redis_bin = 'redis-cli'
      @elasticsearch_url = ENV['ELASTICSEARCH_URL'].presence
      @meilisearch_url = ENV['MEILISEARCH_URL'].presence
      @redis_url = ENV['REDIS_URL'].presence
    end
  end
end
