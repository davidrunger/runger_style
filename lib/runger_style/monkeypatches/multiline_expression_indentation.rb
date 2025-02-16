# frozen_string_literal: true

module RungerStyle::MultilineExpressionIndentationPatches
  private

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
