# frozen_string_literal: true

require 'stalker/bun'
require 'stalker/bundler'
require 'stalker/command'
require 'stalker/elasticsearch'
require 'stalker/engine'
require 'stalker/linux'
require 'stalker/meilisearch'
require 'stalker/mysql'
require 'stalker/node_packages'
require 'stalker/npm'
require 'stalker/postgresql'
require 'stalker/redis'
require 'stalker/ruby'
require 'stalker/sqlite'
require 'stalker/version'
require 'stalker/yarn'

module Stalker
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :access_token, :node_bin, :npm_bin, :yarn_bin, :bun_bin, :redis_bin, :elasticsearch_url, :elasticsearch_ca_file, :meilisearch_url, :meilisearch_api_key, :redis_url

    def initialize
      # nil (or blank) denies every request; set it to false to explicitly disable authentication
      @access_token = nil
      @node_bin = 'node'
      @npm_bin = 'npm'
      @yarn_bin = 'yarn'
      @bun_bin = 'bun'
      @redis_bin = 'redis-cli'
      @elasticsearch_url = ENV['ELASTICSEARCH_URL'].presence
      @elasticsearch_ca_file = ENV['ELASTICSEARCH_CA_FILE'].presence
      @meilisearch_url = ENV['MEILISEARCH_URL'].presence
      @meilisearch_api_key = ENV['MEILISEARCH_API_KEY'].presence
      @redis_url = ENV['REDIS_URL'].presence
    end

    # No effect since 0.3.0 (IP filtering replaced by access_token). Still accepted because existing initializers
    # set it (e.g. HTTP_LB_CLIENTIP on Squark) and must keep booting
    def client_ip_header=(_value); end
  end
end
