# frozen_string_literal: true

module Stalker
  class Redis
    TIMEOUT = 1

    def self.enabled?
      !!Stalker.configuration.redis_url
    rescue
      false
    end

    def self.version
      return unless enabled?

      { name: 'redis', dep_type: 'db_server', version: server_info[/^redis_version:(\S+)/, 1] }
    end

    # Prefer the client already loaded by the app (redis-client for Sidekiq 7+, redis gem otherwise): redis-cli is rarely installed on app servers
    def self.server_info
      url = Stalker.configuration.redis_url

      if defined?(::RedisClient)
        client = ::RedisClient.config(url: url, connect_timeout: TIMEOUT, read_timeout: TIMEOUT, write_timeout: TIMEOUT).new_client
        begin
          client.call('INFO', 'server')
        ensure
          client.close
        end
      elsif defined?(::Redis::VERSION)
        client = ::Redis.new(url: url, connect_timeout: TIMEOUT, read_timeout: TIMEOUT, write_timeout: TIMEOUT, reconnect_attempts: 0)
        begin
          client.info('server').map { |key, value| "#{key}:#{value}" }.join("\n")
        ensure
          client.close
        end
      else
        cli_server_info(URI(url))
      end
    end
    private_class_method :server_info

    # Credentials go through REDISCLI_AUTH/--user instead of the URL: redis-cli rejects an empty username
    # (redis://:password@host) and URL arguments are visible in the process list
    def self.cli_server_info(uri)
      host_url = URI::Generic.build(scheme: uri.scheme, host: uri.host, port: uri.port, path: uri.path).to_s
      user_args = uri.user.present? ? ['--user', uri.decoded_user] : []
      env = uri.password ? { 'REDISCLI_AUTH' => uri.decoded_password } : {}

      Command.run(Stalker.configuration.redis_bin, '-u', host_url, *user_args, 'INFO', 'SERVER', env: env)
    end
    private_class_method :cli_server_info
  end
end
