# frozen_string_literal: true

Rails.application.routes.draw do
  mount Stalker::Engine => '/stalker'
end
