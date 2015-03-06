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
    "defaults/template.haml",
    "defaults/style.css"
  ]
  s.homepage    = "http://rubygems.org/gems/hola"
  s.license     = "BSD-3-Clause"
  s.executables = [ "spiffy" ]
  s.add_runtime_dependency "github-markup", "~> 1.3", ">= 1.3.3"
  s.add_runtime_dependency "redcarpet", "~> 3.2", ">= 3.2.2"
  s.add_runtime_dependency "RedCloth", "~> 4.2", ">= 4.2.9"
  s.add_runtime_dependency "rdoc", "3.6.1"
  s.add_runtime_dependency "org-ruby", "~> 0.9", ">= 0.9.12"
  s.add_runtime_dependency "creole", "~> 0.5", ">= 0.5.0"
  s.add_runtime_dependency "wikicloth", "~> 0.8", ">= 0.8.2"
  s.add_runtime_dependency "asciidoctor", "~> 1.5", ">= 1.5.2"
  s.add_runtime_dependency "haml", "~> 4.0", ">= 4.0.6"
end