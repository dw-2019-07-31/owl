$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "return_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "return_engine"
  s.version     = ReturnEngine::VERSION
  s.authors     = ["Yuichi Nakano"]
  s.email       = ["y_nakano@dadway.com"]
  s.homepage    = "http://dadway.com"
  s.summary     = "come come beer."
  s.description = "come come beer."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.6"

  s.add_development_dependency "sqlite3"
end
