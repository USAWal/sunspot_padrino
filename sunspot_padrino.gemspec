# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sunspot_padrino/version'

Gem::Specification.new do |spec|
  spec.name          = "sunspot_padrino"
  spec.version       = SunspotPadrino::VERSION
  spec.authors       = ["Valeriy Utyaganov"]
  spec.email         = ["usawal@gmail.com"]
  spec.summary       = %q{Adoptation of sunspot rails for padrino}
  spec.description   = %q{Adoptation of sunspot rails for padrino}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "sunspot"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
