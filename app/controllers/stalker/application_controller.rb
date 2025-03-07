# frozen_string_literal: true

module Stalker
  class ApplicationController < ActionController::API
    before_action do
      client_ip = request.env.fetch(Stalker.configuration.client_ip_header, request.remote_ip)
      head :unauthorized if Stalker.configuration.whitelist_ips.exclude?(client_ip)
    end
  end
end
