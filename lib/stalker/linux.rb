# frozen_string_literal: true

module Stalker
  class Linux
    OS_RELEASE = '/etc/os-release'

    def self.enabled?
      File.exist?(OS_RELEASE)
    end

    def self.version
      return unless enabled?

      if File.exist?('/etc/debian_version')
        version = File.read('/etc/debian_version').strip

        { name: 'debian', dep_type: 'os', version: version }
      else
        os_release = parse_os_release(File.read(OS_RELEASE))

        { name: os_release['ID'], dep_type: 'os', version: os_release['VERSION_ID'] }
      end
    end

    # Format spec: https://www.freedesktop.org/software/systemd/man/latest/os-release.html
    def self.parse_os_release(content)
      content.each_line.with_object({}) do |line, data|
        line = line.strip
        next if line.empty? || line.start_with?('#')

        key, value = line.split('=', 2)
        next if value.nil?

        data[key.strip] = unquote(value.strip)
      end
    end
    private_class_method :parse_os_release

    def self.unquote(value)
      case value
      when /\A"(.*)"\z/ then Regexp.last_match(1).gsub(/\\([$"`\\])/, '\1')
      when /\A'(.*)'\z/ then Regexp.last_match(1)
      else value
      end
    end
    private_class_method :unquote
  end
end
