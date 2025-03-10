## Unreleased
### Internal
- Move default custom cops and monkeypatches to `default/` subdirectory. This will make it possible to also add cops/monkeypatches for other plugins in other subdirectories (e.g. capybara) that we don't want to require/include in the default config.

## v5.6.0 (2025-03-10)
- Switch from `require` to `plugins` for `rubocop-rspec_rails` ruleset (`rulesets/rspec_rails.yml`).
- Switch from `require` to `plugins` for `rubocop-capybara` ruleset (`rulesets/capybara.yml`).

## v5.5.0 (2025-03-06)
- Switch from `require` to `plugins` for `rubocop-factory_bot` ruleset (`rulesets/factory_bot.yml`).

## v5.4.0 (2025-02-17)
- Register `rubocop-rspec` as a plugin (rather than requiring it).

## v5.3.1 (2025-02-16)
- Enforce `RungerStyle/ArgumentAlignment` on macro method calls with parentheses.

## v5.3.0 (2025-02-16)
- Disable `Rails/Delegate` cop.
- Register `rubocop-rails` as a plugin (rather than requiring it).
- Register `rubocop-performance` and `rubocop-rake` as plugins (rather than requiring them).

## v5.2.0 (2025-02-16)
- Disable `Metrics/CyclomaticComplexity` cop.
- Monkeypatch `RuboCop::Cop::MultilineExpressionIndentation` to require (via `Layout/MultilineMethodCallIndentation`) the indentation of a chained multiline method call used as a method argument.
- Change `Layout/MultilineMethodCallIndentation` `EnforcedStyle` from `indented` to `indented_relative_to_receiver`, monkeypatch `RuboCop::Cop::Layout::MultilineMethodCallIndentation`, and further monkeypatch `RuboCop::Cop::MultilineExpressionIndentation` in order to avoid undesirable `Layout/MultilineMethodCallIndentation` autocorrections.

## v5.1.0 (2025-02-12)
- Monkeypatch `RuboCop::Cop::MultilineElementLineBreaks` so that arrays will be considered multiline if the array brackets are on separate lines (even if all elements are on a single line).

## v5.0.1 (2025-02-11)
- Fix `RungerStyle/MultilineHashValueIndentation` false positive on multiline keys.

## v5.0.0 (2025-02-11)
- **BREAKING:** Rename `MemoizingMethods` config option for `RungerStyle/FirstArgumentIndentation` to `DecoratorMethods`.
- Add `helper_method` to default `RungerStyle/FirstArgumentIndentation` `DecoratorMethods`.
- Add `RungerStyle/ArgumentAlignment` cop, which ignores [macro](https://rubydoc.info/github/rubocop/rubocop-ast/RuboCop/AST/MethodDispatchNode#macro%3F-instance_method) methods.
- Remove `Layout/MultilineAssignmentLayout` custom config that included `send`.
- Specify `EnforcedStyle: consistent` for `Layout/FirstHashElementIndentation`.

## v4.5.0 (2025-02-11)
- Add custom `RungerStyle/MultilineHashValueIndentation` cop.
- Add custom `RungerStyle/FirstArgumentIndentation` cop.

## v4.4.1 (2025-02-10)
- Remove `RSpec/DescribeClass` custom config.

## v4.4.0 (2025-02-09)
- Fix false negative for `RungerStyle/MultilineMethodArgumentsLineBreaks` with keyword arguments.
- Disable `Style/Next`.

## v4.3.0 (2025-01-31)
- Specify `EnforcedShorthandSyntax: always` for `Style/HashSyntax`.

## v4.2.2 (2025-01-27)
- Fix `RungerStyle/MultilineMethodArgumentsLineBreaks` false positives.

## v4.2.1 (2025-01-27)
- Explicitly declare `module RungerStyle` in `RungerStyle/MultilineMethodArgumentsLineBreaks` definition.

## v4.2.0 (2025-01-27)
- Add `RungerStyle/MultilineMethodArgumentsLineBreaks` cop.

## v4.1.0 (2025-01-11)
- Enable `Style/BlockDelimiters` (except for `expect` method)

## v4.0.1 (2024-12-31)
- Increase TargetRubyVersion from 3.3 to 3.4

## v4.0.0 (2024-12-31)
[no unreleased changes yet]

## v3.0.0 (2024-12-11)
- Increase minimum required `rubocop` version to 1.68.0.

## v2.19.0 (2024-12-10)
- Disable `Style/SafeNavigationChainLength` cop.

## v2.18.0 (2024-12-10)
- Remove upper bounds on versions for all dependencies.

## v2.17.0 (2024-09-03)
- Ignore long annotate comments about indexes (re: `Layout/LineLength`)

## v2.16.0 (2024-08-08)
- Ignore RSpec `context` and `describe` lines for `Layout/LineLength` (as we are already doing for `it`)

## v2.15.0 (2024-08-05)
- Add `EnforcedStyleAlignWith: start_of_block` for `Layout/BlockAlignment` cop

## v2.14.0 (2024-08-05)
- Allow `127.0.0.1` as an IP address for `Style/IpAddresses`

## v2.13.0 (2024-07-23)
- Ignore `Layout/LineLength` for RSpec example descriptions

## v2.12.0 (2024-07-11)
- Disable `Style/FormatString` cop

## v2.11.0 (2024-07-05)
- Set `AllowMultilineFinalElement: true` for `Layout/FirstMethodArgumentLineBreak`

## v2.10.0 (2024-07-05)
- Enable `Layout/FirstMethodArgumentLineBreak`

## v2.9.0 (2024-06-28)
- Enforce only major and minor parts of required Ruby version (loosening the required Ruby version from 3.3.3 to 3.3.0)

## v2.8.0 (2024-06-16)
- Enforce indented style for `Layout/MultilineOperationIndentation`

## v2.7.0 (2024-06-15)
- Rename primary branch from `master` to `main`

## v2.6.0 (2024-06-12)
- Move RSpecRails cop to separate YAML file

## v2.5.0 (2024-06-10)
- Reenable `Layout/HeredocIndentation` cop

## v2.4.0 (2024-05-23)
- Set `ActiveSupportExtensionsEnabled` to true in `rails.yml`

## v2.3.0 (2024-05-17)
- Disable `Layout/HeredocIndentation` temporarily due to prism/rubocop bugs

## v2.2.1 (2024-04-01)
[no unreleased changes yet]

## v2.2.0 (2024-03-23)
- Limit ForbiddenPrefixes for Naming/PredicateName to "is_"

## v2.1.0 (2024-03-15)
- Remove global exclusions and lint db/schema.rb except for some cops

## v2.0.0 (2024-03-08)
- Use prism as parser

## v1.7.0 (2024-02-28)
- Enable `Style/Semicolon` with `AllowAsExpressionSeparator: true`

## v1.6.0 (2024-02-02)
- Specify Ruby version in Gemfile (via .ruby-version file)

## v1.5.0 (2024-02-02)
- Source Ruby version from `.ruby-version` file

## v1.4.0 (2024-02-01)
- Disable `Style/MultilineBlockChain`

## v1.3.0 (2024-01-04)
- Disable `Capybara/NegationMatcher`

## v1.2.0 (2023-12-29)
- Disable `Style/ArgumentsForwarding`
- Disable `Naming/BlockForwarding`

## v1.1.0 (2023-12-29)
### Changed
- Disable `Style/MultilineMethodSignature` cop

## v1.0.0 (2023-12-29)
### Changed
- Bump target Ruby from 3.2 to 3.3

## v0.6.0 (2023-12-04)
### Changed
- Disable `Style/RedundantParentheses` cop
- Disable `Layout/ConditionPosition` cop
- Disable `Style/ArrayFirstLast` cop

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
