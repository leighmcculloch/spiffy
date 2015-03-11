require_relative "lib/spiffy_version"

Gem::Specification.new do |s|
  s.name        = "spiffy"
  s.version     = SpiffyVersion::VERSION
  s.date        = "2015-03-08"
  s.summary     = "A markdown to HTML & PDF converter."
  s.description = "A markdown to HTML & PDF converter, with simple ERB & HAML templating and CSS styling."
  s.authors     = ["Leigh McCulloch"]
  s.email       = "leigh@mcchouse.com"
  s.files       = [
    "lib/spiffy_version.rb",
    "lib/spiffy_cli.rb",
    "lib/spiffy.rb",
    "templates/default.haml",
    "templates/default.css"
  ]
  s.homepage    = "http://rubygems.org/gems/hola"
  s.license     = "BSD-3-Clause"
  s.executables = ["spiffy"]
  s.add_runtime_dependency("github-markdown", "~> 0.6", ">= 0.6.8")
  s.add_runtime_dependency("github-markup", "~> 1.3", ">= 1.3.3")
  s.add_runtime_dependency("pdfkit", "~> 0.6", ">= 0.6.2")
  s.add_runtime_dependency("wkhtmltopdf-binary", "~> 0.9", ">= 0.9.9.3")
  s.add_runtime_dependency("haml", "~> 4.0", ">= 4.0.6")
end