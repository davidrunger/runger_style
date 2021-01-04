## Unreleased
### Added
- Disable `Rails/OrderById` in `rulesets/rails.yml`

## v0.2.6 (2021-01-01)
### Added
- Don't require parens for `timestamps` method calls

### Internal
- Use Ruby 2.7.2 (not 2.7.1) in GitHub Actions

## v0.2.5 (2020-09-01)
### Added
- Disable `Layout/EmptyLineAfterMultilineCondition` cop
- Disable `Style/ClassMethodsDefinitions` cop

## v0.2.4 (2020-08-05)
### Added
- Disable `Lint/MissingSuper` rule
- Specify `required_ruby_version` (`>= 2.7.0`) in gemspec

## v0.2.3 (2020-07-13)
### Added
- Disable `Style/HashLikeCase` rule

## v0.2.2 (2020-07-13)
### Added
- Disable `Style/RedundantFileExtensionInRequire` rule

## v0.2.1 (2020-07-02)
### Docs
- Alphabetize suggested ordering of `:development` and `:test` groups in Gemfile

## v0.2.0 (2020-07-02)
### BREAKING CHANGE
- Break up rulesets based on plugin gem, not code directory

## v0.1.3 (2020-07-01)
### Added
- Don't require parens for `#inet` calls in migrations

## v0.1.2 (2020-07-01)
### Docs
- Fix typo in README.md ("spec-specific" => "binstubs-specific")

## v0.1.1 (2020-07-01)
### Added
- Add rulesets specifically designed for `spec/` and `db/migrate/` directories

## v0.1.0 (2020-07-01)
- Initial release of `runger_style`!
