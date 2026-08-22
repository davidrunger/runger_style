# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class ParenthesesAroundMultilineCondition < ::RuboCop::Cop::Base
    extend ::RuboCop::Cop::AutoCorrector
    include ::RuboCop::Cop::RangeHelp

    MSG = 'Wrap multiline `%<keyword>s` conditions in parentheses.'

    def on_if(node)
      if offense?(node)
        add_offense(node.loc.keyword, message: format(MSG, keyword: node.keyword)) do |corrector|
          autocorrect(corrector, node)
        end
      end
    end

    private

    def offense?(node)
      multiline_conditional?(node) &&
        !permitted_multiline_condition?(node) &&
        !correctly_parenthesized?(node)
    end

    def correctly_parenthesized?(node)
      inner_condition = parenthesized_condition(node.condition)

      if inner_condition
        condition_starts_on_next_line?(node, inner_condition) &&
          closing_parenthesis_on_own_line?(node.condition, inner_condition)
      end
    end

    def multiline_conditional?(node)
      !node.modifier_form? && !node.ternary? && node.condition.multiline?
    end

    def permitted_multiline_condition?(node)
      condition = node.condition

      condition.any_block_type? || multiline_parenthesized_receiver?(condition)
    end

    def multiline_parenthesized_receiver?(condition)
      if condition.send_type? || condition.csend_type?
        receiver = condition.receiver
        receiver&.begin_type? && receiver.multiline?
      end
    end

    def autocorrect(corrector, node)
      condition = node.condition
      inner_condition = parenthesized_condition(condition)
      condition_start =
        if inner_condition
          inner_condition.source_range.begin_pos
        else
          condition.source_range.begin_pos
        end

      if inner_condition
        if !condition_starts_on_next_line?(node, inner_condition)
          corrector.replace(
            range_between(node.loc.keyword.end_pos, condition_start),
            " (\n#{condition_indentation(node)}",
          )
        end

        if !closing_parenthesis_on_own_line?(condition, inner_condition)
          corrector.replace(
            range_between(inner_condition.source_range.end_pos, condition.loc.end.end_pos),
            "\n#{base_indentation(node)})",
          )
        end
      else
        corrector.replace(
          range_between(node.loc.keyword.end_pos, condition_start),
          " (\n#{condition_indentation(node)}",
        )

        condition_end = condition_end_position(condition)
        corrector.insert_after(
          range_between(condition_end, condition_end),
          "\n#{base_indentation(node)})",
        )
      end
    end

    def condition_starts_on_next_line?(node, inner_condition)
      inner_condition.first_line > node.loc.keyword.line
    end

    def closing_parenthesis_on_own_line?(condition, inner_condition)
      condition.loc.end.line > inner_condition.source_range.last_line
    end

    def parenthesized_condition(condition)
      if (
        condition.begin_type? &&
          condition.children.one? &&
          condition.loc.begin &&
          condition.loc.end
      )
        condition.children.first
      end
    end

    def condition_end_position(condition)
      end_position = condition.source_range.end_pos
      last_line = condition.source_range.last_line

      processed_source.comments.each do |comment|
        if comment.location.line == last_line && comment.source_range.begin_pos >= end_position
          end_position = comment.source_range.end_pos
        end
      end

      end_position
    end

    def base_indentation(node)
      node.loc.keyword.source_line[/\A[ \t]*/]
    end

    def condition_indentation(node)
      base_indentation(node) + (' ' * indentation_width)
    end

    def indentation_width
      config.for_cop('Layout/IndentationWidth')['Width'] || 2
    end
  end
end
