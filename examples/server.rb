require_relative '../lib/Polytalk/server.rb'
require_relative 'model/order.rb'

class Test
  def self.add (a, b)
    return a + b
  end

  def self.shout (words)
    words.upcase
  end
end

server = Polytalk::Server.new({ port: 9090 })
server.run do |connection, request|
  response = server.call(request)
  server.push(connection, response)
end