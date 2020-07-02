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

<!-- Added by: david, at: Wed Jul  1 14:46:44 PDT 2020 -->

<!--te-->

# Installation

Add this line to your application's Gemfile:

```rb
# file: Gemfile

group :test, :development do
  gem 'runger_style', github: 'davidrunger/runger_style', require: false
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
    - rulesets/default.yml # gem 'rubocop'
    - rulesets/performance.yml # gem 'rubocop-performance'
    - rulesets/rails.yml # gem 'rubocop-rails'
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
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  # (as mentioned in the "Installation" section, you need the `runger_style` gem itself, too)
  gem 'runger_style', github: 'davidrunger/runger_style', require: false
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
