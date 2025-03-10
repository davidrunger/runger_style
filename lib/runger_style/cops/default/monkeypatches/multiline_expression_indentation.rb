# frozen_string_literal: true

module RungerStyle::MultilineExpressionIndentationPatches
  private

  def left_hand_side(lhs)
    while (
      lhs.parent&.call_type? &&
      lhs.parent.loc.dot &&
      !lhs.parent.assignment_method? &&
      !(lhs.parent.parenthesized_call? && lhs.parent.arguments.include?(lhs))
    )
      lhs = lhs.parent
    end

    lhs
  end

  # Modified from https://github.com/rubocop/rubocop/blob/v1.72.1/lib/rubocop/cop/mixin/multiline_expression_indentation.rb#L194-L198.
  def not_for_this_cop?(node)
    node.ancestors.any? do |ancestor|
      grouped_expression?(ancestor)
    end
  end
end

RuboCop::Cop::MultilineExpressionIndentation.prepend(
  RungerStyle::MultilineExpressionIndentationPatches,
)

module RungerStyle::MultilineMethodCallIndentationPatches
  private

  def alignment_base(node, rhs, given_style)
    case given_style
    when :aligned
      semantic_alignment_base(node, rhs) || syntactic_alignment_base(node, rhs)
    when :indented
      nil
    when :indented_relative_to_receiver
      if ([node] + node.ancestors).any? { |node| !node.parenthesized_call? }
        nil
      else
        receiver_alignment_base(node)
      end
    end
  end
end

RuboCop::Cop::Layout::MultilineMethodCallIndentation.prepend(
  RungerStyle::MultilineMethodCallIndentationPatches,
)
