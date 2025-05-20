# frozen_string_literal: true

Stalker.configure do |config|
  # Set it to false if you want to disable the access token
  config.access_token = Rails.application.credentials.stalker_token
end
