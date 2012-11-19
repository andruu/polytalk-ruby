# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'polytalk/version'

Gem::Specification.new do |gem|
  gem.name          = "polytalk"
  gem.version       = Polytalk::VERSION
  gem.authors       = ["Andrew Weir"]
  gem.email         = ["andru.weir@gmail.com"]
  gem.description   = %q{Polytalk is a simple protocol which allows communication between different languages via TCP.}
  gem.summary       = %q{Polytalk is a simple protocol which allows communication between different languages via TCP.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
