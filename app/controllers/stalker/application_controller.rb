# frozen_string_literal: true

module Stalker
  class ApplicationController < ActionController::API
    before_action :authenticate

    private

      def authenticate
        access_token = Stalker.configuration.access_token

        # false is the only way to disable authentication: a missing token (e.g. unset ENV variable) must not open the endpoint
        return if access_token == false

        if access_token.blank?
          Rails.logger.warn('[Stalker] access_token is not configured, request denied')
          return head :unauthorized
        end

        head :unauthorized unless ActiveSupport::SecurityUtils.secure_compare(request_token, access_token.to_s)
      end

      # The Authorization header keeps the token out of access logs; ?token= is kept for existing monitoring clients
      def request_token
        request.authorization.to_s[/\ABearer (.+)\z/, 1] || params[:token].to_s
      end
  end
end
