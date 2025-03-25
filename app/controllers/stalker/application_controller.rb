# frozen_string_literal: true

module Stalker
  class ApplicationController < ActionController::API
    before_action do
      token = params[:token].to_s

      if Stalker.configuration.access_token && !ActiveSupport::SecurityUtils.secure_compare(token, Stalker.configuration.access_token.to_s)
        head :unauthorized
      end
    end
  end
end
