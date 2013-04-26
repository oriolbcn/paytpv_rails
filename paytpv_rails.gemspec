# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paytpv_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "paytpv-rails"
  spec.version       = PaytpvRails::VERSION
  spec.authors       = ["David Ramirez, Oriol Collell"]
  spec.email         = ["oriol.collell@adconfig.com"]
  spec.description   = %q{PayTPV products integration for rails apps}
  spec.summary       = %q{PayTPV products integration for rails apps}
  spec.homepage      = "https://github.com/oriolbcn/paytpv_rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  
  spec.add_dependency(%q<savon>, ["~> 1.2.0"])
  
end
