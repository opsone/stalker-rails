# frozen_string_literal: true

module Stalker
  class DependenciesController < ApplicationController
    PROBES = [
      [Stalker::Linux, :version],
      [Stalker::Mysql, :version],
      [Stalker::Postgresql, :version],
      [Stalker::Sqlite, :version],
      [Stalker::Redis, :version],
      [Stalker::Elasticsearch, :version],
      [Stalker::Meilisearch, :version],
      [Stalker::Ruby, :version],
      [Stalker::Bundler, :version],
      [Stalker::Bundler, :dependencies],
      [Stalker::Bun, :version],
      [Stalker::Bun, :dependencies],
      [Stalker::Npm, :version],
      [Stalker::Npm, :dependencies],
      [Stalker::Yarn, :version],
      [Stalker::Yarn, :dependencies]
    ].freeze

    def index
      data = Rails.cache.fetch('stalker_dependencies', expires_in: 5.minutes) do
        PROBES.map { |probe, method_name| run_probe(probe, method_name) }.flatten.compact
      end

      render json: data
    end

    private

      # A failing probe must not break the whole report
      def run_probe(probe, method_name)
        probe.public_send(method_name)
      rescue StandardError => e
        Rails.logger.error("[Stalker] #{probe}.#{method_name} failed: #{e.class}: #{e.message}")
        nil
      end
  end
end
