# frozen_string_literal: true

Stalker.configure do |config|
  # Required to access the endpoint (?token=...). Requests are denied when it is nil or blank.
  # Set it to false to explicitly disable authentication.
  config.access_token = Rails.application.credentials.stalker_token

  # Elasticsearch over TLS: use an https:// URL (credentials in the URL if needed: https://user:password@host:9200)
  # and point to the CA of a self-signed certificate (defaults to ENV['ELASTICSEARCH_CA_FILE'])
  # config.elasticsearch_ca_file = '/etc/elasticsearch/certs/http_ca.crt'

  # Only needed when Meilisearch runs with a master key (defaults to ENV['MEILISEARCH_API_KEY'])
  # config.meilisearch_api_key = ENV['MEILISEARCH_API_KEY']
end
