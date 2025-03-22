# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class MultilineMethodArgumentsLineBreaks < ::RuboCop::Cop::Base
    extend ::RuboCop::Cop::AutoCorrector
    include ::RuboCop::Cop::RangeHelp

    MSG = 'Each argument in a multi-line method call must start on a separate line.'

    def on_send(node)
      if node.arguments? && multiline_method_call?(node)
        # When a method call uses keyword arguments without braces,
        # the parser produces a single hash node. In that case, inspect its pairs.
        arguments =
          if node.arguments.one? &&
              node.arguments.first.hash_type? &&
              !node.arguments.first.braces?
            node.arguments.first.pairs
          else
            node.arguments
          end

        arguments.each_cons(2) do |arg1, arg2|
          if same_line?(arg1, arg2)
            separator = separator_range(arg1, arg2)

            add_offense(separator, message: MSG) do |corrector|
              base_indent = base_indentation(arg1)
              replacement = ",\n#{base_indent}"
              corrector.replace(separator, replacement)
            end
          end
        end
      end
    end

    private

    def multiline_method_call?(node)
      # Compare the line of the method name (selector) to the end line of the last argument.
      node.loc.selector.line != node.arguments.last.loc.last_line
    end

    def same_line?(arg1, arg2)
      arg1.source_range.last_line == arg2.source_range.first_line
    end

    def base_indentation(arg)
      arg.source_range.source_line[/^\s*/]
    end

    def separator_range(arg1, arg2)
      range_between(arg1.source_range.end_pos, arg2.source_range.begin_pos)
    end
  end
end
