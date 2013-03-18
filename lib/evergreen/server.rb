module Evergreen
  class Server
    attr_reader :suite

    def serve
      server.boot

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

