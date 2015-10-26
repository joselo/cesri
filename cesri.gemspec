# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cesri/version'

Gem::Specification.new do |spec|
  spec.name          = "cesri"
  spec.version       = Cesri::VERSION
  spec.authors       = ["Jose Carrion"]
  spec.email         = ["joseloc@gmail.com"]

  spec.summary       = %q{Gema Ruby que permite consumir los servicios web expuestos por el SRI para comprobantes electronicos en Ecuador.}
  spec.description   = %q{Gema Ruby que permite consumir los servicios web expuestos por el SRI para comprobantes electronicos en Ecuador.}
  spec.homepage      = "https://github.com/joselo/cesri"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "savon", "~> 2.3.0"

  spec.add_development_dependency "bundler", "~> 1.10.6"
  spec.add_development_dependency "rake", "~> 0"
  spec.add_development_dependency "rspec", "~> 3.3"

end
