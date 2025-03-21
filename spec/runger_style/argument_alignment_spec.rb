# frozen_string_literal: true

RSpec.describe RungerStyle::ArgumentAlignment, :config do
  let(:cop_config) do
    {
      'EnforcedStyle' => style,
      'SupportedStyles' => [style],
    }
  end

  context 'when EnforcedStyle is with_first_argument' do
    let(:style) { 'with_first_argument' }

    context 'when the method being called is a macro' do
      context 'when multiline arguments are not aligned' do
        context 'when called without parens' do
          it 'accepts any indentation of the second argument' do
            expect_no_offenses(<<~RUBY)
              get 'some stuff',
                'and more stuff'
            RUBY
          end
        end

        context 'when called with parens' do
          it 'complains and corrects it' do
            expect_offense(<<~RUBY)
              create(
                :ci_step_result,
              :cpu_time,
              ^^^^^^^^^ Align the arguments of a method call if they span more than one line.
              )
            RUBY

            expect_correction(<<~RUBY)
              create(
                :ci_step_result,
                :cpu_time,
              )
            RUBY
          end
        end
      end
    end

    context 'when the method being called is not a macro' do
      it 'indents subsequent arguments to align with the first' do
        expect_offense(<<~RUBY)
          foo.bar 'some stuff',
            'and more stuff'
            ^^^^^^^^^^^^^^^^ Align the arguments of a method call if they span more than one line.
        RUBY

        expect_correction(<<~RUBY)
          foo.bar 'some stuff',
                  'and more stuff'
        RUBY
      end
    end
  end
end
