$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'hound/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'hound'
  s.version     = Hound::VERSION
  s.authors     = ['Lee Jarvis']
  s.email       = ['ljjarvis@gmail.com']
  s.homepage    = 'https://github.com/injekt/hound'
  s.summary     = 'Trace changes to your models'
  s.description = 'Trace your model actions and create activity lists'

  s.files = `git ls-files`.split($/)
  s.test_files = s.files.grep(%r{^test/})

  s.add_dependency 'rails', '>= 3.2.0'

  s.add_development_dependency 'sqlite3'
end
