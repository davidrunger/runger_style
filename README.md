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
  gem 'runger_style'
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
  runger_style:
    - default.yml
```

Then, run:

```bash
$ bundle exec rubocop
```

You do not need to include rubocop directly in your application's dependencies. Instead,
`runger_style` depends on specific versions of `rubocop`, `rubocop-rspec`, and `rubocop-performance`
that will be shared across all projects.

# Inspiration / Credits

This gem is inspired by (/ largely copied from) https://github.com/percy/percy-style , which was
written about here: https://blog.percy.io/share-rubocop-rules-across-all-of-your-repos-f3281fbd71f8
.
