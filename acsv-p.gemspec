$:.push File.expand_path('../lib', __FILE__)
require 'acsv-p/version'

Gem::Specification.new do |s|
  s.name        = 'acsv-p'
  s.version     = ACSV::VERSION
  s.date        = '2014-11-24'
  s.authors     = ['wvengen']
  s.email       = 'dev-rails@willem.engen.nl'
  s.summary     = 'Read CSV files without configuration'
  s.description = "A wrapper for Ruby's standard CSV class that auto-detects column separator and file encoding."
  s.homepage    = 'https://github.com/wvengen/ruby-acsv-p'
  s.license     = 'GPL-3.0+'

  s.files       = Dir["lib/**/*"]

  # test with different character detection libraries
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'charlock_holmes', '~> 0.7.3'
end
