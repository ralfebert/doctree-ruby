# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doctree/version'

Gem::Specification.new do |spec|
  spec.name          = "doctree"
  spec.version       = DocTree::VERSION
  spec.authors       = ["Ralf Ebert"]
  spec.email         = ["info@ralfebert.de"]

  spec.summary       = %q{Generates table of contents documents in the .doctree format.}
  spec.homepage      = "https://doctree.org/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rubytree"
  spec.add_dependency "nokogiri"
  spec.add_dependency "trollop"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
end
