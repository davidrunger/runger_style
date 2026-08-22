# frozen_string_literal: true

RSpec.describe RungerStyle::NoReturn, :config do
  it 'accepts methods that use implicit returns' do
    expect_no_offenses(<<~RUBY)
      def answer
        42
      end
    RUBY
  end

  it 'reports explicit returns without autocorrecting them' do
    expect_offense(<<~RUBY)
      def answer(value)
        if value
          return value
          ^^^^^^ Do not use `return`.
        else
          nil
        end
      end
    RUBY

    expect_no_corrections
  end

  it 'reports returns without an argument and returns inside blocks' do
    expect_offense(<<~RUBY)
      def answer(value)
        return unless value
        ^^^^^^ Do not use `return`.

        [value].each { return }
                       ^^^^^^ Do not use `return`.
      end
    RUBY
  end

  it 'ignores return in comments and strings' do
    expect_no_offenses(<<~RUBY)
      # return an answer
      message = 'return an answer'
    RUBY
  end
end
