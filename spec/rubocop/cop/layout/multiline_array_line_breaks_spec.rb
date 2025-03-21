# frozen_string_literal: true

# NOTE: Most of these specs are simply copied from RuboCop, maybe with some minor style changes.
# Search for 'This spec is modified from the original in rubocop'
# to find substantively modified one(s).

RSpec.describe RuboCop::Cop::Layout::MultilineArrayLineBreaks, :config do
  context 'when on same line' do
    it 'does not add any offenses' do
      expect_no_offenses(<<~RUBY)
        [1,2,3]
      RUBY
    end
  end

  context 'when on same line, separate line from brackets' do
    # NOTE: This spec is modified from the original in rubocop.
    # All other specs in this file are substantively unmodified.
    it 'registers an offense and autocorrects it' do
      expect_offense(<<~RUBY)
        [
          1, 2, 3,
                ^ Each item in a multi-line array must start on a separate line.
             ^ Each item in a multi-line array must start on a separate line.
        ]
      RUBY

      # NOTE: This autocorrection is imperfect, but it will be refined further up by other cops.
      expect_correction(<<~RUBY)
        [
          1,#{trailing_whitespace}
        2,#{trailing_whitespace}
        3,
        ]
      RUBY
    end
  end

  context 'when two elements on same line' do
    it 'registers an offense and corrects' do
      expect_offense(<<~RUBY)
        [1,
          2, 4]
             ^ Each item in a multi-line array must start on a separate line.
      RUBY

      expect_correction(<<~RUBY)
        [1,
          2,\s
        4]
      RUBY
    end
  end

  context 'when nested arrays' do
    it 'registers an offense and corrects' do
      expect_offense(<<~RUBY)
        [1,
          [2, 3], 4]
                  ^ Each item in a multi-line array must start on a separate line.
      RUBY

      expect_correction(<<~RUBY)
        [1,
          [2, 3],\s
        4]
      RUBY
    end
  end
end
