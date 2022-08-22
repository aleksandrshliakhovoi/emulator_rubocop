# frozen_string_literal: true

require_relative 'lib/modules/version'

Gem::Specification.new do |spec|
  spec.name = 'emulator_rubocop'
  spec.version = Modules::VERSION
  spec.authors = ['O S']
  spec.email = ['aleksandrshliakhovoi@gmail.com']
  spec.summary = 'Rubocop emulation on ruby'
  spec.description = 'Rubocop emulation on ruby'
  spec.homepage = 'https://github.com/aleksandrshliakhovoi/emulator_rubocop'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'
  spec.metadata['allowed_push_host'] = 'https://github.com/aleksandrshliakhovoi/emulator_rubocop'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/aleksandrshliakhovoi/emulator_rubocop'
  spec.metadata['changelog_uri'] = 'https://github.com/aleksandrshliakhovoi/emulator_rubocop'
  spec.files = Dir.glob('{lib,bin}/**/*')
  spec.bindir        = ['bin']
  spec.executables = ['emulator_rubocop']
  spec.require_paths = ['lib']
  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'bundler', '~> 2.2.25'
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
