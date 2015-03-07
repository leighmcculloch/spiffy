Gem::Specification.new do |s|
  s.name        = "spiffy"
  s.version     = "0.0.3"
  s.date        = "2015-03-06"
  s.summary     = "A markup to HTML & PDF converter."
  s.description = "A markup to HTML & PDF converter. Supports all markups supported by Github, including markdown, rdoc, etc."
  s.authors     = ["Leigh McCulloch"]
  s.email       = "leigh@mcchouse.com"
  s.files       = [
    "lib/spiffy.rb",
    "templates/default.haml",
    "templates/default.css"
  ]
  s.homepage    = "http://rubygems.org/gems/hola"
  s.license     = "BSD-3-Clause"
  s.executables = [ "spiffy" ]
  s.add_runtime_dependency "redcarpet", "~> 3.2", ">= 3.2.2"
end