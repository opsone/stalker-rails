# frozen_string_literal: true

require 'open3'
require 'shellwords'
require 'timeout'

module Stalker
  # Runs an external command without a shell (arguments are never interpreted), from the application root
  module Command
    TIMEOUT = 5

    def self.run(bin, *args, env: {})
      command = Shellwords.split(bin) + args

      Open3.popen2(env, *command, chdir: Rails.root.to_s, err: File::NULL, pgroup: true) do |stdin, stdout, wait_thread|
        stdin.close

        begin
          Timeout.timeout(TIMEOUT) { stdout.read }
        rescue Timeout::Error
          kill(wait_thread.pid)
          # Arguments are left out of the message: they may contain credentials (e.g. Redis URL)
          raise Timeout::Error, "#{bin} timed out after #{TIMEOUT}s"
        end
      end
    end

    def self.kill(pid)
      Process.kill('KILL', -pid)
    rescue Errno::ESRCH
      nil
    end
    private_class_method :kill
  end
end
