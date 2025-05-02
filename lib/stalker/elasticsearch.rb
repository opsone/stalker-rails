# frozen_string_literal: true

require 'json'
require 'net/http'

module Stalker
  class Elasticsearch
    def self.enabled?
      Stalker.configuration.elasticsearch_url && Net::HTTP.start(uri.host, uri.port, read_timeout: 1) { |http| http.head('/').code == '200' }
    rescue
      false
    end

    def self.version
      return unless enabled?

      data = JSON.parse(Net::HTTP.get(uri))

      { name: 'elasticsearch', dep_type: 'search_server', version: data['version']['number'] }
    end

    private

      def self.uri
        URI(Stalker.configuration.elasticsearch_url)
      end
  end
end
