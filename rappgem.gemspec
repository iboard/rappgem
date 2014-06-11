# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rappgem/version'

Gem::Specification.new do |spec|
  spec.name          = "rappgem"
  spec.version       = Rappgem::VERSION
  spec.authors       = ["Andi Altendorfer"]
  spec.email         = ["andi@iboard.cc"]
  spec.summary       = %q{ A simple ruby application as a gem }
  spec.description   = %q{ You may use this as a starter/bootstrap ruby gem }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-given"
  spec.add_development_dependency "simplecov"

end
