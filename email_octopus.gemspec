# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'email_octopus/version'

Gem::Specification.new do |spec|
  spec.name          = "email_octopus"
  spec.version       = EmailOctopus::VERSION
  spec.authors       = ["Tom Scott"]
  spec.email         = ["tscott@weblinc.com"]

  spec.summary       = 'API Client for Email Octopus'
  spec.description   = 'API client for Email Octopus'
  spec.homepage      = 'https://github.com/tubbo/email_octopus'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "rake", "~> 12"
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency "dotenv", "~> 2.5"

  spec.add_dependency 'activemodel'
  spec.add_dependency 'httparty'
end
