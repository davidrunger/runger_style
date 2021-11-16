# frozen_string_literal: true

require_relative 'lib/runger_style/version'

Gem::Specification.new do |spec|
  spec.name          = 'runger_style'
  spec.version       = RungerStyle::VERSION
  spec.authors       = ['David Runger']
  spec.email         = ['davidjrunger@gmail.com']

  spec.summary       = 'Shared rubocop rules for the preferred Ruby coding style of @davidrunger'
  spec.description   = 'Shared rubocop rules for the preferred Ruby coding style of @davidrunger'
  spec.homepage      = 'https://github.com/davidrunger/runger_style'
  spec.license       = 'MIT'

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['allowed_push_host'] = 'https://www.davidrunger.com/'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/davidrunger/runger_style'
  spec.metadata['changelog_uri'] =
    'https://github.com/davidrunger/runger_style/blob/master/CHANGELOG.md'

  spec.files =
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7.0'
end
