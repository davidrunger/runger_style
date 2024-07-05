# `runger_style`

Shared rubocop rules for the preferred Ruby coding style of [@davidrunger][1].

[1]: https://github.com/davidrunger/

# Table of Contents

<!--ts-->
   * [runger_style](#runger_style)
   * [Table of Contents](#table-of-contents)
   * [Installation](#installation)
   * [Usage](#usage)
   * [Inspiration / Credits](#inspiration--credits)
   * [For maintainers](#for-maintainers)

<!-- Added by: david, at: Tue Jan 26 02:54:38 PST 2021 -->

<!--te-->

# Installation

Add this to your application's Gemfile:

```rb
group :development, :test do
  gem 'runger_style', require: false
end
```

And then run:

```
$ bundle install
```

# Usage

Create a `.rubocop.yml` file, including as many of the directives below as appropriate/desired.

```yml
# file: .rubocop.yml

inherit_gem:
  runger_style:
    - rulesets/capybara.yml # gem 'rubocop-capybara'
    - rulesets/default.yml # gem 'rubocop'
    - rulesets/factory_bot.yml # gem 'rubocop-factory_bot'
    - rulesets/performance.yml # gem 'rubocop-performance'
    - rulesets/rails.yml # gem 'rubocop-rails'
    - rulesets/rake.yml # gem 'rubocop-rake'
    - rulesets/rspec_rails.yml # gem 'rubocop-rspec_rails'
    - rulesets/rspec.yml # gem 'rubocop-rspec'
```

For example, if you're setting up rubocop configuration for a Ruby on Rails app, then it's a good
idea to include `rulesets/rails.yml`. If your application or library uses RSpec for testing, then
it's a good idea to include `rulesets/rspec.yml`. If you care about performance, then it's a good
idea to include `rulesets/performance.yml`.

For each directive that you choose to include, **you'll need to make sure to also include the
corresponding gem** (as noted in a comment for each directive in the `.rubocop.yml` snippet above)
in the `Gemfile` of your application or library.

```rb
# file: Gemfile

group :development, :test do
  # include whichever of these gems are required, based on which ruleset(s) you use
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  # (as mentioned in the "Installation" section, you need the `runger_style` gem itself, too)
  gem 'runger_style', require: false
end
```

Then, run:

```
$ bundle exec rubocop
```

# Inspiration / Credits

This gem is inspired by (/ largely copied from) https://github.com/percy/percy-style , which was
written about here: https://blog.percy.io/share-rubocop-rules-across-all-of-your-repos-f3281fbd71f8
.

# For maintainers

To release a new version, run `bin/release` with an appropriate `--type` option, e.g.:

```
bin/release --type minor
```

(This uses the `release_assistant` gem.)
