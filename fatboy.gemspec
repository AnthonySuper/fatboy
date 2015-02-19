# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fatboy/version'

Gem::Specification.new do |spec|
  spec.name          = "fatboy"
  spec.version       = Fatboy::VERSION
  spec.authors       = ["Anthony Super"]
  spec.email         = ["anthony@noided.media"]
  spec.summary       = %q{Fatboy keeps track of your models's views, right here, right now.}
  spec.description = %q{
  Fatboy is a gem designed to easily keep track of views.
  It doesn't touch your SQL, and stays slim in redis.
  It also makes it easy to query based on how viewed something is.
  }
  spec.homepage      = "http://github.com/AnthonySuper/fatboy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "timecop", "~> 0.7.3"
  spec.add_development_dependency "mock_redis", "~> 0.14.0"
  spec.add_development_dependency "simplecov", "~> 0.9.2"
  spec.add_runtime_dependency "redis", "~> 3.2.1"
  spec.required_ruby_version = ">= 2.0"

end
