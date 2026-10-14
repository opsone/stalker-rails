# frozen_string_literal: true

require 'json'
require 'net/http'

module Stalker
  class Elasticsearch
    TIMEOUT = 1

    def self.enabled?
      Stalker.configuration.elasticsearch_url && request(Net::HTTP::Head, '/').code == '200'
    rescue
      false
    end

    def self.version
      return unless enabled?

      data = JSON.parse(request(Net::HTTP::Get, uri.request_uri).body)

      { name: 'elasticsearch', dep_type: 'search_server', version: data['version']['number'] }
    end

    def self.uri
      URI(Stalker.configuration.elasticsearch_url)
    end
    private_class_method :uri

    # TLS follows the URL scheme, credentials come from the URL (https://user:password@host:9200)
    def self.request(request_class, path)
      request = request_class.new(path)
      request.basic_auth(uri.decoded_user, uri.decoded_password) if uri.user

      options = { use_ssl: uri.scheme == 'https', open_timeout: TIMEOUT, read_timeout: TIMEOUT }
      options[:ca_file] = Stalker.configuration.elasticsearch_ca_file if Stalker.configuration.elasticsearch_ca_file

      Net::HTTP.start(uri.host, uri.port, options) { |http| http.request(request) }
    end
    private_class_method :request
  end
end
