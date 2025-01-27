# frozen_string_literal: true

class RungerStyle::MultilineMethodArgumentsLineBreaks < RuboCop::Cop::Base
  extend RuboCop::Cop::AutoCorrector
  include RuboCop::Cop::RangeHelp

  MSG = 'Each argument in a multi-line method call must start on a separate line.'

  def on_send(node)
    return unless node.multiline?
    return if node.arguments.size <= 1

    node.arguments.each_cons(2) do |arg1, arg2|
      next unless same_line?(arg1, arg2)

      separator = separator_range(arg1, arg2)

      add_offense(separator, message: MSG) do |corrector|
        base_indent = base_indentation(arg1)
        replacement = ",\n#{base_indent}"
        corrector.replace(separator, replacement)
      end
    end
  end

  private

  def same_line?(arg1, arg2)
    arg1.source_range.last_line == arg2.source_range.first_line
  end

  def base_indentation(arg)
    arg.source_range.source_line[/^\s*/]
  end

  def separator_range(arg1, arg2)
    end_pos = arg1.source_range.end.end_pos
    begin_pos = arg2.source_range.begin.begin_pos
    range_between(end_pos, begin_pos)
  end
end
