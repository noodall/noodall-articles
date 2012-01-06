$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "noodall/articles/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "noodall-articles"
  s.version     = Noodall::Articles::VERSION
  s.authors     = ["Steve England"]
  s.email       = ["steve@wearebeef.co.uk"]
  s.homepage    = "https://github.com/noodall/noodall-articles"
  s.summary     = "Adds simple blog like functionality to Noodall"
  s.description = "Adds simple blog like functionality to Noodall"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.3"
  # s.add_dependency "jquery-rails"

end
