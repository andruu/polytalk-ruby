# Polytalk

Polytalk is a simple protocol which allows communication between different languages via TCP.

Polytalk currently supports PHP, Node.js and Ruby.

## Protocol

The protocol is a simple language agnostic JSON object containing the channel, class, method and arguments. It will then return an response as either a string or JSON object.

Key          | Value
------------ | ------------- 
class        | The class to call the method on. Namespaced classes require the `::` separator.
method       | The method you want to call.
arguments    | The arguments to inject into the method in key value pairs.

## Installation

Add this line to your application's Gemfile:

    gem 'polytalk'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install polytalk

## Server Example

Be sure that any classes you want to be exposed by the server to the client are included/required from the server.

```ruby
server = Polytalk::Server.new({ port: 9090 })
server.run do |connection, request|
  response = server.call(request)
  server.push(connection, response)
end
```

## Client Example
  
```ruby
request = {
    class: 'Model::Order',
    method: 'findBySize',
    arguments: {
      size: 'large',
      limit: 3
    }
}

client = Polytalk::Client.new({ port: 9090 })

puts client.call(request)

# Passing a block
first = client.call(request) do |r|
  r.first
end
puts first
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### License

MIT, see LICENSE.