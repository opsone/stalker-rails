# frozen_string_literal: true

require 'json'
require 'net/http'

module Stalker
  class Meilisearch
    def self.enabled?
      Stalker.configuration.meilisearch_url && Net::HTTP.start(uri.host, uri.port, read_timeout: 1) { |http| http.get('/health').code == '200' }
    rescue
      false
    end

    def self.version
      return unless enabled?

      data = JSON.parse(Net::HTTP.get(uri))

      { name: 'meilisearch', dep_type: 'search_server', version: data['pkgVersion'] }
    end

    private

      def self.uri
        URI("#{Stalker.configuration.meilisearch_url}/version")
      end
  end
end
