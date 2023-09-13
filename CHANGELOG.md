## Unreleased
[no unreleased changes yet]

## v0.5.1 (2023-09-13)
### Changed
- Move FactoryBot cops into factory_bot ruleset

## v0.5.0 (2023-09-13)
### Added
- Add factory_bot ruleset

## v0.4.0 (2023-06-26)
### Changed
- Disable `FactoryBot/AssociationStyle` cop

## v0.3.0 (2023-05-25)
### Changed
- Disable `Metrics/ModuleLength` cop

## v0.2.23 (2023-05-23)
[no unreleased changes yet]

## v0.2.22 (2023-05-04)
[no unreleased changes yet]

## v0.2.21 (2021-06-28)
[no unreleased changes yet]

## v0.2.20 (2021-05-19)
### Changed
- Disable `Style/TopLevelMethodDefinition` in `db/datamigrate/`

## v0.2.19 (2021-05-19)
### Changed
- Allow reads for `Rails/EnvironmentVariableAccess`

## v0.2.18 (2021-05-10)
### Changed
- Disable `Layout/SingleLineBlockChain` cop

## v0.2.17 (2021-05-10)
### Changed
- Disable `Bundler/GemVersion` cop

## v0.2.16 (2021-01-26)
### Dependencies
- Bump `release_assistant` to `0.1.1.alpha`

## v0.2.15 (2021-01-26)
### Internal
- Add some new steps to CI (check for alpha version, no git diff, etc)
- Use `release_assistant` gem to manage the release process

## v0.2.14 (2021-01-09)
### Added
- Don't require parens for `change_column_default` method calls

## v0.2.13 (2021-01-08)
### Added
- Don't require parens for `and` method calls (e.g. in RSpec compound expectations)

## v0.2.12 (2021-01-08)
### Added
- Don't require parens for `boolean` method calls

## v0.2.11 (2021-01-07)
### Added
- Added `Layout/EmptyLineBetweenDefs` with `AllowAdjacentOneLineDefs: true` option

## v0.2.10 (2021-01-07)
### Changed
- Moved `AttributeDefinedStatically` from `FactoryBot` namespace to `RSpec/FactoryBot`

## v0.2.9 (2021-01-07)
### Added
- Disabled `Layout/FirstMethodArgumentLineBreak`

## v0.2.8 (2021-01-04)
### Added
- Disabled `Naming/VariableNumber`
- Disabled `Style/CommentAnnotation`
- Disabled `Style/RedundantArgument`

## v0.2.7 (2021-01-03)
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
