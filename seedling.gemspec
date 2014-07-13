# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seedling/version'

Gem::Specification.new do |spec|
  spec.name          = "seedling"
  spec.version       = Seedling::VERSION
  spec.authors       = ["RealNobody"]
  spec.email         = ["Erik.Littell@Deem.com"]
  spec.description   = %q{A system for organizing and simplifying seeding your environment.}
  spec.summary       = %q{A system for organizing and simplifying seeding your environment.}
  spec.homepage      = "https://github.com/RealNobody/seedling"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
