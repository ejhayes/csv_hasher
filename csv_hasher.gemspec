# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_hasher/version'

Gem::Specification.new do |spec|
  spec.name          = "csv_hasher"
  spec.version       = CsvHasher::VERSION
  spec.authors       = ["Eric Hayes"]
  spec.email         = ["ejhayes@jacobianengineering.com"]
  spec.summary       = %q{Outputs a CSV file with a specified column replaced with a corresponding hash}
  spec.description   = %q{Outputs a CSV file with a specified column replaced with a corresponding hash}
  spec.homepage      = ""
  spec.license       = "Proprietary"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "trollop"
  spec.add_runtime_dependency 'ruby-progressbar'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "debugger"
end
