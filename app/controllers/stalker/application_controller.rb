# frozen_string_literal: true

module Stalker
  class ApplicationController < ActionController::API
    before_action do
      auth_token = params[:token] 

      head :unauthorized if Stalker.configuration.access_token && auth_token != Stalker.configuration.access_token
    end
  end
end
