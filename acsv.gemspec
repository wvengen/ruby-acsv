$:.push File.expand_path('../lib', __FILE__)
require 'acsv/version'

Gem::Specification.new do |s|
  s.name        = 'acsv'
  s.version     = ACSV::VERSION
  s.date        = '2014-11-24'
  s.authors     = ['wvengen']
  s.email       = 'dev-rails@willem.engen.nl'
  s.summary     = 'Read CSV files without configuration'
  s.description = "A wrapper for Ruby's standard CSV class that auto-detects column separator and file encoding."
  s.homepage    = 'https://github.com/wvengen/ruby-acsv'
  s.license     = 'MIT'

  s.files       = Dir["lib/**/*"]

  # test with different character detection libraries
  s.add_development_dependency 'rspec', '~> 3.1.0'
  s.add_development_dependency 'charlock_holmes', '~> 0.7.3'
  s.add_development_dependency 'rchardet', '~> 1.4.2'
  s.add_development_dependency 'uchardet', '~> 0.1.3'
end
