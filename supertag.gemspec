# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'supertag/version'

Gem::Specification.new do |spec|
  spec.name          = "supertag"
  spec.version       = Supertag::VERSION
  spec.authors       = ["Taylor Mitchell"]
  spec.email         = ["scy0846@gmail.com"]
  spec.description   = %q{Parse, store retreive and format tags in your text.}
  spec.summary       = %q{Supertag finds tags with #,$,%, and @. See Readme.}
  spec.homepage      = "https://github.com/scy0846/supertag"
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
