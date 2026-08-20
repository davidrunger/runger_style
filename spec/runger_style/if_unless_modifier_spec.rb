# frozen_string_literal: true

RSpec.describe RungerStyle::IfUnlessModifier, :config do
  it 'accepts multiline if and unless conditionals' do
    expect_no_offenses(<<~RUBY)
      if ready?
        start
      end

      unless stopped?
        continue
      end
    RUBY
  end

  it 'complains about and corrects a trailing if condition' do
    expect_offense(<<~RUBY)
      start if ready?
            ^^ Use a multiline conditional instead of a trailing `if` condition.
    RUBY

    expect_correction(<<~RUBY)
      if ready?
        start
      end
    RUBY
  end

  it 'complains about and corrects a trailing unless condition' do
    expect_offense(<<~RUBY)
      continue unless stopped?
               ^^^^^^ Use a multiline conditional instead of a trailing `unless` condition.
    RUBY

    expect_correction(<<~RUBY)
      unless stopped?
        continue
      end
    RUBY
  end

  it 'preserves a trailing comment with the condition' do
    expect_offense(<<~RUBY)
      enable_coverage(:branch) if !SpecHelper.is_ci? # Codecov doesn't respect
                               ^^ Use a multiline conditional instead of a trailing `if` condition.
    RUBY

    expect_correction(<<~RUBY)
      if !SpecHelper.is_ci? # Codecov doesn't respect
        enable_coverage(:branch)
      end
    RUBY
  end

  it 'indents multiline guarded code' do
    expect_offense(<<~RUBY)
      perform(
        first_argument,
        second_argument,
      ) if ready?
        ^^ Use a multiline conditional instead of a trailing `if` condition.
    RUBY

    expect_correction(<<~RUBY)
      if ready?
        perform(
          first_argument,
          second_argument,
        )
      end
    RUBY
  end
end
