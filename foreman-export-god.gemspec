# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "foreman-export-god"
  s.version     = "0.0.1"
  s.authors     = ["Bob Potter"]
  s.email       = ["bobby.potter@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Add the ability to export god config files to foreman}
  s.description = %q{Add the ability to export god config files to foreman}

  s.rubyforge_project = "foreman-export-god"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "foreman"
end
