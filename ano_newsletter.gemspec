$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ano_newsletter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ano_newsletter"
  s.version     = AnoNewsletter::VERSION
  s.authors     = ["David John"]
  s.email       = ["djohn@arch-no.org"]
  s.homepage    = "http://it.arch-no.org"
  s.summary     = "Google Calendar Rails Engine"
  s.description = "Google Calendar integration for the ano_ suite of rails engines"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ">= 4.1"
  s.add_development_dependency "sqlite3"

  s.add_dependency 'sass-rails', '>= 4'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency "slim-rails"
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'paperclip'
  s.add_dependency 'momentjs-rails', '~> 2.5.0'
  s.add_dependency 'bootstrap3-datetimepicker-rails'
  s.add_dependency 'cancan'
  s.add_dependency 'bootstrap_form'
end
