# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fnordmetric/monitor/version'

Gem::Specification.new do |spec|
  spec.name          = "fnordmetric-monitor"
  spec.version       = Fnordmetric::Monitor::VERSION
  spec.authors       = ["Sergey Boltushkin"]
  spec.email         = ["sergey.boltushkin@gmail.com"]
  spec.summary       = %q{monitors gauses in fnordmetric}
  spec.description   = %q{sends notifications when values not in allowed ranges}
  spec.homepage      = "http://github.com/bscoder/fnordmetric-monitor"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
