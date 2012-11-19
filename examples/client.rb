require_relative '../lib/Polytalk/client.rb'

request = {
    class: 'Model::Order',
    method: 'findBySize',
    arguments: {
      size: 'large',
      limit: 3
    }
}

request2 = {
    class: 'Test',
    method: 'add',
    arguments: {
      a: 2,
      b: 3
    }
}

request3 = {
    class: 'Test',
    method: 'shout',
    arguments: {
      words: 'hello how are you doing?'
    }
}

client = Polytalk::Client.new({ port: 9090 })

puts client.call(request)

# Passing a block
first = client.call(request) do |r|
  r.first
end
puts first

puts client.call(request2)
puts client.call(request3)