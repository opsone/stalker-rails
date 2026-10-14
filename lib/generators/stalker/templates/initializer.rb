# frozen_string_literal: true

Stalker.configure do |config|
  # Required to access the endpoint (?token=...). Requests are denied when it is nil or blank.
  # Set it to false to explicitly disable authentication.
  config.access_token = Rails.application.credentials.stalker_token
end
