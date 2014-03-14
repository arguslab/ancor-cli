require File.expand_path '../lib/ancor/cli/version', __FILE__

Gem::Specification.new do |s|
  s.name = 'ancor-cli'
  s.version = Ancor::CLI::VERSION.dup
  s.authors = ['Ian Unruh', 'Alex Bardas']
  s.email = ['iunruh@ksu.edu', 'bardasag@ksu.edu']
  s.license = 'MIT'
  s.homepage = 'https://github.com/arguslab/ancor-cli'
  s.description = 'CLI used to interact with the ANCOR server API'
  s.summary = 'CLI used to interact with the ANCOR server API'

  s.executables = ['ancor']
  s.files = Dir['LICENSE', 'README.md', 'lib/**/*']
  s.test_files = Dir['spec/**/*']
  s.require_path = 'lib'

  s.add_dependency 'faraday', '~> 0.9'
  s.add_dependency 'formatador', '~> 0.2'
  s.add_dependency 'thor', '~> 0.18'

  s.add_development_dependency 'rspec', '~> 2.14'
end
