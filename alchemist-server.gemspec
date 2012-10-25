# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "alchemist-server/version"

Gem::Specification.new do |s|
  s.name        = "alchemist-server"
  s.version     = Alchemist::Server::VERSION
  s.authors     = ["David Vollbracht"]
  s.email       = ["david@flipstone.com"]
  s.homepage    = "https://github.com/flipstone/alchemist-server"
  s.summary     = %q{Server process for the Alchemist game}
  s.description = %q{}

  s.rubyforge_project = "alchemist-server"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_development_dependency "ffi-ncurses", ">= 0.4.0"

  s.add_runtime_dependency "rb-readline"
  s.add_runtime_dependency "hamster"
  s.add_runtime_dependency "eventmachine", ">= 1.0"
  s.add_runtime_dependency "alchemist-core", ">= 0.0.1"
end
