# frozen_string_literal: true

module Stalker
  class Ruby
    def self.version
      { name: 'ruby', dep_type: 'ruby', version: RUBY_VERSION }
    end
  end
end
