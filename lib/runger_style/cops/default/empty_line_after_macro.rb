# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class EmptyLineAfterMacro < ::RuboCop::Cop::Base
    extend ::RuboCop::Cop::AutoCorrector
    include ::RuboCop::Cop::RangeHelp

    MSG = 'Add an empty line after a macro call.'

    def on_begin(node)
      if class_or_module_scope?(node)
        node.children.each_cons(2) do |previous_node, next_node|
          macro_call = macro_call_node(previous_node)
          next_macro_call = macro_call_node(next_node)

          if macro_call && !next_macro_call && !empty_line_between?(previous_node, next_node)
            add_offense(macro_call.loc.selector, message: MSG) do |corrector|
              autocorrect(corrector, previous_node, next_node)
            end
          end
        end
      end
    end

    private

    def macro_call_node(node)
      method_call = node
      if node.any_block_type?
        method_call = node.send_node
      end

      if method_call.send_type? && macro_call?(method_call)
        method_call
      end
    end

    def macro_call?(node)
      node.macro? || node.self_receiver?
    end

    def class_or_module_scope?(node)
      node.parent&.class_type? || node.parent&.module_type? || node.parent&.sclass_type?
    end

    def empty_line_between?(previous_node, next_node)
      first_line = previous_node.source_range.last_line
      last_line = next_node.source_range.first_line - 1

      processed_source.lines[first_line...last_line].any?(&:blank?)
    end

    def autocorrect(corrector, previous_node, next_node)
      if previous_node.source_range.last_line == next_node.source_range.first_line
        corrector.replace(
          range_between(previous_node.source_range.end_pos, next_node.source_range.begin_pos),
          "\n\n",
        )
      else
        corrector.insert_after(range_by_whole_lines(previous_node.source_range), "\n")
      end
    end
  end
end
