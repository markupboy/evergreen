module Evergreen
  class Server
    attr_reader :suite

    def serve
      server.boot

      # https://github.com/TLSLLC/evergreen/commit/49808a1827887752302ea2ce1b08b107c9e26174
      trap(:INT) { puts ""; Kernel.exit(0) }
      trap(:TERM) { Kernel.exit(0) }
      trap(:QUIT) { Kernel.exit(0) }

      Launchy.open(server.url(Evergreen.mounted_at.to_s + '/'))
      sleep
    end

  protected

    def server
      @server ||= Capybara::Server.new(Evergreen.application)
    end
  end
end

