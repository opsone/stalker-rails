# frozen_string_literal: true

Stalker::Engine.routes.draw do
  get 'dependencies', to: 'dependencies#index'
end
