module Polytalk
  class Client

    require 'socket'
    require 'json'

    def initialize(config = {})
      @port = config['port'] || 9090
      @host = config['host'] || '127.0.0.1'
    end

    def call(request)
      client = TCPSocket.new(@host, @port)
      client.print request.to_json
      response = client.recv(2048)
      client.close

      if response.kind_of?(String) && (response.match(/^{/) || response.match(/^\[{/))
        response = JSON.parse(response)
      end
          
      if block_given?
        yield(response)
      else
        return response
      end

    end

  end
end