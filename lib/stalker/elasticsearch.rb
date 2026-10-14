# frozen_string_literal: true

require 'json'
require 'net/http'

module Stalker
  class Elasticsearch
    TIMEOUT = 1

    def self.enabled?
      Stalker.configuration.elasticsearch_url && request { |http| http.head('/') }.code == '200'
    rescue
      false
    end

    def self.version
      return unless enabled?

      data = JSON.parse(request { |http| http.get(uri.request_uri) }.body)

      { name: 'elasticsearch', dep_type: 'search_server', version: data['version']['number'] }
    end

    def self.uri
      URI(Stalker.configuration.elasticsearch_url)
    end
    private_class_method :uri

    def self.request(&block)
      Net::HTTP.start(uri.host, uri.port, open_timeout: TIMEOUT, read_timeout: TIMEOUT, &block)
    end
    private_class_method :request
  end
end
