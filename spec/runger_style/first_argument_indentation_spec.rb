# frozen_string_literal: true

RSpec.describe RungerStyle::FirstArgumentIndentation, :config do
  let(:cop_config) do
    {
      'EnforcedStyle' => style,
      'SupportedStyles' => [style],
      'DecoratorMethods' => %w[helper_method memoize],
    }
  end

  let(:other_cops) { { 'Layout/IndentationWidth' => { 'Width' => indentation_width } } }

  ruby_version =
    YAML.load_file(
      'rulesets/default.yml',
      permitted_classes: [Regexp],
    ).dig('AllCops', 'TargetRubyVersion')

  context "when the Ruby version is #{ruby_version}" do
    let(:ruby_version) { ruby_version }

    context 'when EnforcedStyle is consistent' do
      let(:style) { 'consistent' }

      context 'when IndentationWidth:Width is 2' do
        let(:indentation_width) { 2 }

        context 'when "decorating" with method(s) listed in DecoratorMethods' do
          it 'accepts the method definition being aligned with the "decorator" call' do
            expect_no_offenses(<<~'RUBY')
              class SomeClass
                helper_method \
                memoize \
                def expensive_method
                  do_something_expensive
                end
              end
            RUBY
          end
        end

        context 'when "decorating" with a method not listed in DecoratorMethods' do
          it 'complains about and indents the method definition' do
            expect_offense(<<~'RUBY')
              class SomeClass
                memo_wise \
                def expensive_method
                ^^^^^^^^^^^^^^^^^^^^ Indent the first argument one step more than the start of the previous line.
                  do_something_expensive
                end
              end
            RUBY

            expect_correction(<<~'RUBY')
              class SomeClass
                memo_wise \
                  def expensive_method
                    do_something_expensive
                  end
              end
            RUBY
          end
        end
      end
    end
  end
end
