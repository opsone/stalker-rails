# frozen_string_literal: true

require 'stalker/bun'
require 'stalker/bundler'
require 'stalker/engine'
require 'stalker/linux'
require 'stalker/npm'
require 'stalker/ruby'
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
    attr_accessor :client_ip_header, :whitelist_ips, :node_bin, :npm_bin, :yarn_bin, :bun_bin, :elasticsearch_url, :meilisearch_url

    def initialize
      @whitelist_ips = []
      @node_bin = 'node'
      @npm_bin = 'npm'
      @yarn_bin = 'yarn'
      @bun_bin = 'bun'
      @elasticsearch_url = ENV['ELASTICSEARCH_URL']
      @meilisearch_url = ENV['MEILISEARCH_URL']
    end

    def whitelist_ips
      (%w[127.0.0.1 ::1] + @whitelist_ips).uniq
    end
  end
end
