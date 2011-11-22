# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'mongo_utils'
require "mongo_utils/version"

Gem::Specification.new do |s|
  s.name        = "mongo_utils"
  s.version     = MongoUtils::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Sharp"]
  s.email       = ["ajsharp@gmail.com"]
  s.homepage    = "https://github.com/ajsharp/mongo_utils"
  s.summary     = %q{A collection of utilities for working with MongoDB.}
  s.description = %q{A collection of utilities for working with MongoDB.}

  s.rubyforge_project = "mongo_utils"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'mongo',         '~> 1.3.0'
  s.add_dependency 'activesupport', '~> 3.0'
  s.add_dependency 'mongoid',       '~> 2.0'
  s.add_dependency 'bson_ext'
end
