# frozen_string_literal: true

module Stalker
  class DependenciesController < ApplicationController
    def index
      data = Rails.cache.fetch('stalker_dependencies', expires_in: 5.minutes) do
        [
          Stalker::Linux.version,
          Stalker::Ruby.version,
          Stalker::Bundler.version,
          Stalker::Bundler.dependencies,
          Stalker::Bun.version,
          Stalker::Bun.dependencies,
          Stalker::Npm.version,
          Stalker::Npm.dependencies,
          Stalker::Yarn.version,
          Stalker::Yarn.dependencies
        ].flatten.compact
      end

      render json: data
    end
  end
end
