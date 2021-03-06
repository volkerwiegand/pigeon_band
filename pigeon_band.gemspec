# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pigeon_band/version'

Gem::Specification.new do |spec|
  spec.name          = "pigeon_band"
  spec.version       = PigeonBand::VERSION
  spec.authors       = ["Volker Wiegand"]
  spec.email         = ["volker.wiegand@cvw.de"]
  spec.summary       = %q{Pigeon band formatter}
  spec.description   = %q{Format year and collation sequence for pigeon bands of various countries}
  spec.homepage      = PigeonBand::HOMEPAGE
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'
  spec.add_dependency 'activerecord', '~> 4.0'
  
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
