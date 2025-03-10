# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class MultilineHashValueIndentation < ::RuboCop::Cop::Base
    extend ::RuboCop::Cop::AutoCorrector

    MSG = 'Hash value should be indented by two spaces relative to its key.'

    def on_pair(node)
      key_node = node.key
      value_node = node.value

      # Only check if the value starts on a line after the key ends.
      if key_node.loc.expression.last_line != value_node.source_range.line

        key_column = key_node.source_range.column
        expected_value_column = key_column + 2
        actual_value_column = value_node.source_range.column

        if actual_value_column != expected_value_column
          add_offense(value_node, message: MSG) do |corrector|
            buffer = value_node.source_range.source_buffer
            # Get the entire line where the value starts.
            line_range = buffer.line_range(value_node.source_range.line)
            # Create a range covering just the indentation of that line.
            indentation_range =
              Parser::Source::Range.new(
                buffer,
                line_range.begin_pos,
                value_node.source_range.begin_pos,
              )
            # Replace the existing indentation with the expected number of spaces.
            corrector.replace(indentation_range, ' ' * expected_value_column)
          end
        end
      end
    end
  end
end
