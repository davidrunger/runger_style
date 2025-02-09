# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'

RSpec.describe RungerStyle::MultilineMethodArgumentsLineBreaks do
  include RuboCop::RSpec::ExpectOffense

  subject(:cop) { described_class.new }

  ruby_version =
    YAML.load_file(
      'rulesets/default.yml',
      permitted_classes: [Regexp],
    ).dig('AllCops', 'TargetRubyVersion')

  context "when the Ruby version is #{ruby_version}" do
    let(:ruby_version) { ruby_version }

    context 'when the method call is on a single line' do
      it 'does not register an offense' do
        expect_no_offenses(<<~RUBY)
          foo(a, b, c)
        RUBY
      end
    end

    context 'when the method call is multi-line with two arguments on the same line' do
      it 'registers an offense and autocorrects it' do
        expect_offense(<<~RUBY)
          foo(
            a, b,
             ^^ RungerStyle/MultilineMethodArgumentsLineBreaks: Each argument in a multi-line method call must start on a separate line.
          )
        RUBY

        expect_correction(<<~RUBY)
          foo(
            a,
            b,
          )
        RUBY
      end
    end

    context 'when the method call is multi-line with two keyword arguments on the same line' do
      it 'registers an offense and autocorrects it' do
        expect_offense(<<~RUBY)
          foo(
            a:, b: 2,
              ^^ RungerStyle/MultilineMethodArgumentsLineBreaks: Each argument in a multi-line method call must start on a separate line.
          )
        RUBY

        expect_correction(<<~RUBY)
          foo(
            a:,
            b: 2,
          )
        RUBY
      end
    end

    context 'when the method call is multi-line with a hash on a single line' do
      it 'does not register an offense' do
        expect_no_offenses(<<~RUBY)
          foo(
            { a:, b: 2 },
          )
        RUBY
      end
    end

    context 'when the method call is multi-line with three arguments on the same line' do
      it 'registers an offense and autocorrects it' do
        expect_offense(<<~RUBY)
          foo(
            a, b, c,
             ^^ RungerStyle/MultilineMethodArgumentsLineBreaks: Each argument in a multi-line method call must start on a separate line.
                ^^ RungerStyle/MultilineMethodArgumentsLineBreaks: Each argument in a multi-line method call must start on a separate line.
          )
        RUBY

        expect_correction(<<~RUBY)
          foo(
            a,
            b,
            c,
          )
        RUBY
      end
    end

    context 'when the method call is multi-line with arguments partially on the same line' do
      it 'registers an offense and autocorrects it' do
        expect_offense(<<~RUBY)
          foo(
            a, b,
             ^^ RungerStyle/MultilineMethodArgumentsLineBreaks: Each argument in a multi-line method call must start on a separate line.
            c,
          )
        RUBY

        expect_correction(<<~RUBY)
          foo(
            a,
            b,
            c,
          )
        RUBY
      end
    end

    context 'when the method call is multi-line and all arguments are already on separate lines' do
      it 'does not register an offense' do
        expect_no_offenses(<<~RUBY)
          foo(
            a,
            b,
            c,
          )
        RUBY
      end
    end

    context 'when the method call has no arguments' do
      it 'does not register an offense' do
        expect_no_offenses(<<~RUBY)
          foo()
        RUBY
      end
    end

    context 'when the method call has a single argument' do
      it 'does not register an offense' do
        expect_no_offenses(<<~RUBY)
          foo(
            a,
          )
        RUBY
      end
    end

    context 'when the method call contains nested method calls as arguments' do
      it 'registers an offense and autocorrects properly' do
        expect_offense(<<~RUBY)
          foo(
            bar(a, b), c,
                     ^^ RungerStyle/MultilineMethodArgumentsLineBreaks: Each argument in a multi-line method call must start on a separate line.
          )
        RUBY

        expect_correction(<<~RUBY)
          foo(
            bar(a, b),
            c,
          )
        RUBY
      end
    end

    context 'when the method call includes trailing comments' do
      it 'preserves the comments and autocorrects properly' do
        expect_offense(<<~RUBY)
          foo(
            a, b, # trailing comment
             ^^ RungerStyle/MultilineMethodArgumentsLineBreaks: Each argument in a multi-line method call must start on a separate line.
          )
        RUBY

        expect_correction(<<~RUBY)
          foo(
            a,
            b, # trailing comment
          )
        RUBY
      end
    end

    context 'when the method call is a chained call' do
      it 'registers an offense and autocorrects properly' do
        expect_offense(<<~RUBY)
          foo.bar(
            a, b,
             ^^ RungerStyle/MultilineMethodArgumentsLineBreaks: Each argument in a multi-line method call must start on a separate line.
          )
        RUBY

        expect_correction(<<~RUBY)
          foo.bar(
            a,
            b,
          )
        RUBY
      end
    end

    context 'when the method call includes a block' do
      it 'registers an offense and autocorrects properly' do
        expect_offense(<<~RUBY)
          foo(
            a, b,
             ^^ RungerStyle/MultilineMethodArgumentsLineBreaks: Each argument in a multi-line method call must start on a separate line.
          ) do |x|
            x.some_method
          end
        RUBY

        expect_correction(<<~RUBY)
          foo(
            a,
            b,
          ) do |x|
            x.some_method
          end
        RUBY
      end
    end

    context 'when the method call is part of a multi-line chain and arguments are on a single line' do
      it 'does not register an offense' do
        expect_no_offenses(<<~RUBY)
          foo.
            bar(a, b)
        RUBY
      end
    end
  end
end
