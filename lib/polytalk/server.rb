module Polytalk
  class Server

    require 'socket'
    require 'json'

    def initialize(config = {})
      @port = config['port'] || 9090
      @host = config['host'] || '127.0.0.1'
    end

    def run
      server = TCPServer.new(@host, @port)
      loop do
        Thread.start(server.accept) do |connection|
          request = connection.recv(2048)
          yield(connection, JSON.parse(request, symbolize_names: true))
        end
      end
    end

    def call(request)
      required_constant = nil
      request[:class].split('::').each_with_index do |c, index|
        if index == 0
          required_constant = Kernel.const_get(c)
        else
          required_constant = required_constant.const_get(c)
        end
      end

      # Convert string prefixed with `:` to symbols
      if request[:arguments].is_a? Hash
        request[:arguments].each do |key, arg|
          if arg.is_a? String
            if arg.match(/^:/)
              request[:arguments][key] = arg[1..-1].to_sym
            end
          end
        end
      end

      required_method = required_constant.method(request[:method])

      if request[:arguments].is_a? Hash
        required_method.call *request[:arguments].values
      else
        required_method.call
      end
    end

    def push(connection, response)
      connection.write(response.to_json)
      connection.close
    end

  end  
end