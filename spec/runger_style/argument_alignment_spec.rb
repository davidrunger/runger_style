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
      context 'when called without parens' do
        it 'accepts fixed indentation of subsequent arguments' do
          expect_no_offenses(<<~RUBY)
            get 'some stuff',
              'and more stuff'
          RUBY
        end

        it 'complains and corrects inconsistent indentation' do
          expect_offense(<<~RUBY)
            class User
              validates :initial_ip,
            :latest_ip,
            ^^^^^^^^^^ Use one level of indentation for arguments following the first line of a multi-line method call.
            :initial_user_agent,
            ^^^^^^^^^^^^^^^^^^^ Use one level of indentation for arguments following the first line of a multi-line method call.
            :latest_user_agent,
            ^^^^^^^^^^^^^^^^^^ Use one level of indentation for arguments following the first line of a multi-line method call.
                :last_active_at,
            presence: true
            ^^^^^^^^^^^^^^ Use one level of indentation for arguments following the first line of a multi-line method call.
            end
          RUBY

          expect_correction(<<~RUBY)
            class User
              validates :initial_ip,
                :latest_ip,
                :initial_user_agent,
                :latest_user_agent,
                :last_active_at,
                presence: true
            end
          RUBY
        end
      end

      context 'when called with parens' do
        it 'accepts alignment with the first argument' do
          expect_no_offenses(<<~RUBY)
            create(
              :ci_step_result,
              :cpu_time,
            )
          RUBY
        end

        it 'complains and corrects misalignment with the first argument' do
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
