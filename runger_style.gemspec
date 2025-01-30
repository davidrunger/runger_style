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
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/davidrunger/runger_style'
  spec.metadata['changelog_uri'] =
    'https://github.com/davidrunger/runger_style/blob/main/CHANGELOG.md'

  spec.files =
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  spec.require_paths = ['lib']

  # HACK: Using public_send rather than read works around a Dependabot bug.
  # rubocop:disable Style/SendWithLiteralMethodName
  required_ruby_version =
    File.public_send(:read, '.ruby-version').
      rstrip.sub(/\A(\d+\.\d+)\.\d+\z/, '\1.0')
  # rubocop:enable Style/SendWithLiteralMethodName
  spec.required_ruby_version = ">= #{required_ruby_version}"

  spec.add_dependency('prism', '>= 0.24.0')
  spec.add_dependency('rubocop', '>= 1.68.0')
end
