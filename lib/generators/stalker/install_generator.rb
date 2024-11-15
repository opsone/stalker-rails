# frozen_string_literal: true

module Stalker
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def create_initializer_file
      template 'initializer.rb', 'config/initializers/stalker.rb'
    end
  end
end
