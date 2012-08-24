# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "william-client/version"

Gem::Specification.new do |gem|
  gem.name        = "william-client"
  gem.version     = William::Client::VERSION
  gem.authors     = ["Josep Jaume", "Marc Divins"]
  gem.email       = ["josepjaume@gmail.com", "marcdivc@gmail.com"]
  gem.homepage    = ""
  gem.summary     = %q{William-client is a simple wrapper for William hypermedia API.}
  gem.description = %q{William-client is a simple wrapper for William hypermedia API.}

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

  # specify any dependencies here; for example:
  gem.add_runtime_dependency "hyperclient", ">= 0.0.7"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "webmock"
end
