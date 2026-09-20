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
          if (
            node.arguments.one? &&
              node.arguments.first.hash_type? &&
              !node.arguments.first.braces?
          )
            node.arguments.first.pairs
          else
            node.arguments
          end

        arguments.each_cons(2) do |arg1, arg2|
          if same_line?(arg1, arg2)
            separator = separator_range(arg1, arg2)

            add_offense(separator, message: MSG) do |corrector|
              corrector.replace(separator, correction_replacement(node, arg1, arg2))

              if indexed_assignment_rhs?(node, arg2)
                indent_continuation_lines(corrector, arg2)
              end
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

    def correction_replacement(node, arg1, arg2)
      if indexed_assignment_rhs?(node, arg2)
        indexed_assignment_replacement(node, arg1)
      else
        base_indent = base_indentation(arg1)
        ",\n#{base_indent}"
      end
    end

    def indexed_assignment_rhs?(node, arg2)
      node.method_name == :[]= && node.arguments.last.equal?(arg2)
    end

    def indexed_assignment_replacement(node, arg1)
      assignment =
        range_between(arg1.source_range.end_pos, node.loc.operator.end_pos).source.rstrip
      indentation = ' ' * indentation_width

      "#{assignment}\n#{base_indentation(arg1)}#{indentation}"
    end

    def indent_continuation_lines(corrector, arg)
      buffer = arg.source_range.source_buffer
      indentation = ' ' * indentation_width

      (arg.source_range.line + 1).upto(arg.source_range.last_line) do |line|
        line_start = buffer.line_range(line).begin_pos
        line_start_range = Parser::Source::Range.new(buffer, line_start, line_start)
        corrector.insert_before(line_start_range, indentation)
      end
    end

    def indentation_width
      config.for_cop('Layout/IndentationWidth')['Width'] || 2
    end

    def separator_range(arg1, arg2)
      range_between(arg1.source_range.end_pos, arg2.source_range.begin_pos)
    end
  end
end
