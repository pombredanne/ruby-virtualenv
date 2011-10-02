# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sandbox/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jacob Radford", "Francesc Esplugas"]
  gem.email         = ["nkryptic@gmail.com", "francesc.esplugas@gmail.com"]
  gem.description   = %q{Create virtual ruby/rubygems environments.}
  gem.summary       = %q{Create virtual ruby/rubygems environments.}
  gem.homepage      = "http://github.com/fesplugas/ruby-virtualenv"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "ruby-virtualenv"
  gem.require_paths = ["lib"]
  gem.version       = Sandbox::VERSION

  gem.add_development_dependency "rspec", "~> 2.6.0"
  gem.add_development_dependency "mocha", "~> 0.10.0"
end
