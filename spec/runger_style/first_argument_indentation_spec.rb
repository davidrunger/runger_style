# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'

RSpec.describe RungerStyle::FirstArgumentIndentation, :config do
  include RuboCop::RSpec::ExpectOffense

  let(:cop_config) do
    {
      'EnforcedStyle' => style,
      'SupportedStyles' => [style],
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

    context 'when EnforcedStyle is consistent_relative_to_receiver' do
      let(:style) { 'consistent_relative_to_receiver' }

      context 'when IndentationWidth:Width is 2' do
        let(:indentation_width) { 2 }

        context 'when memoizing a method listed in MemoizingMethods' do
          let(:cop_config) { super().merge({ 'MemoizingMethods' => %w[memoize] }) }

          it 'accepts the method definition being aligned with the memoize call' do
            expect_no_offenses(<<~'RUBY')
              class SomeClass
                memoize \
                def expensive_method
                  do_something_expensive
                end
              end
            RUBY
          end
        end

        context 'when "decorating" with a method not listed in MemoizingMethods' do
          let(:cop_config) { super().merge({ 'MemoizingMethods' => %w[memoize] }) }

          it 'complains about and indents the method definition' do
            expect_offense(<<~'RUBY')
              class SomeClass
                memo_wise \
                def expensive_method
                ^^^^^^^^^^^^^^^^^^^^ Indent the first argument one step more than `memo_wise \`.
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
