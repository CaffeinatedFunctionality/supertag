# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_usertag/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_usertag"
  spec.version       = SimpleUsertag::VERSION
  spec.authors       = ["Raphael Campardou"] & ["Taylor Mitchell"]
  spec.email         = ["ralovely@gmail.com"] & ["scy0846@yahoo.com"]
  spec.description   = %q{Parse, store retreive and format usertags in your text.}
  spec.summary       = %q{Simple Usertag tags users with an @ to post on their page or reply to a comment}
  spec.homepage      = "https://github.com/scy0846/simple_usertag"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9.3"
  spec.add_dependency "rails", "> 3.2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "sqlite3"
end
