# frozen_string_literal: true

require 'json'
require 'net/http'

module Stalker
  class Meilisearch
    TIMEOUT = 1

    def self.enabled?
      Stalker.configuration.meilisearch_url && request { |http| http.get('/health') }.code == '200'
    rescue
      false
    end

    def self.version
      return unless enabled?

      data = JSON.parse(request { |http| http.get(uri.request_uri, headers) }.body)

      { name: 'meilisearch', dep_type: 'search_server', version: data['pkgVersion'] }
    end

    def self.uri
      URI("#{Stalker.configuration.meilisearch_url}/version")
    end
    private_class_method :uri

    # /version requires a key as soon as Meilisearch runs with a master key
    def self.headers
      api_key = Stalker.configuration.meilisearch_api_key
      api_key ? { 'Authorization' => "Bearer #{api_key}" } : {}
    end
    private_class_method :headers

    def self.request(&block)
      Net::HTTP.start(uri.host, uri.port, open_timeout: TIMEOUT, read_timeout: TIMEOUT, &block)
    end
    private_class_method :request
  end
end
