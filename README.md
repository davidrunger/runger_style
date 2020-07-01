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
group :test, :development do
  gem 'runger_style', github: 'davidrunger/runger_style'
end
```

And then run:

```
$ bundle install
```

# Usage

Create a `.rubocop.yml` file with the following directive:

```yml
inherit_gem:
  runger_style: rulesets/default.yml
```

Then, run:

```
$ bundle exec rubocop
```

If you have a `spec/` directory that contains RSpec tests, then you might also want to create (or
already have) a spec-specific `spec/.rubocop.yml` file and add this content:

```yml
# spec/.rubocop.yml
inherit_gem:
  runger_style: rulesets/specs.yml
```

If you have a `bin/` directory that contains binstubs, then you might also want to create (or
already have) a spec-specific `bin/.rubocop.yml` file and add this content:

```yml
# bin/.rubocop.yml
inherit_gem:
  runger_style: rulesets/bin.yml
```

If you have a `db/migrate/` directory that contains Rails migrations, then you might also want to
create (or already have) a migration-specific `db/migrate/.rubocop.yml` file and add this content:

```yml
# db/migrate/.rubocop.yml
inherit_gem:
  runger_style: rulesets/migrations.yml
```

# Inspiration / Credits

This gem is inspired by (/ largely copied from) https://github.com/percy/percy-style , which was
written about here: https://blog.percy.io/share-rubocop-rules-across-all-of-your-repos-f3281fbd71f8
.
