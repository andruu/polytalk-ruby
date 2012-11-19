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
          yield(connection, JSON.parse(request))
        end
      end
    end

    def call(request)
      required_constant = nil
      request['class'].split('::').each_with_index do |c, index|
        if index == 0
          required_constant = Kernel.const_get(c)
        else
          required_constant = required_constant.const_get(c)
        end
      end
      required_method = required_constant.method(request['method'])
      required_method.call *request['arguments'].values
    end

    def push(connection, response)
      connection.write(response.to_json)
      connection.close
    end

  end  
end