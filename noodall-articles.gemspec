$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "noodall/articles/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "noodall-articles"
  s.version     = Noodall::Articles::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of NoodallArticles."
  s.description = "TODO: Description of NoodallArticles."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.3"
  # s.add_dependency "jquery-rails"

end
