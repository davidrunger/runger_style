# frozen_string_literal: true

module RungerStyle::MultilineElementLineBreaksPatches
  private

  def check_line_breaks(node, children, ignore_last: false)
    return if single_line?(node, children, ignore_last:)

    last_seen_line = -1
    children.each do |child|
      if last_seen_line >= child.first_line
        add_offense(child) do |corrector|
          RuboCop::Cop::EmptyLineCorrector.insert_before(corrector, child)
        end
      else
        last_seen_line = child.last_line
      end
    end
  end

  def single_line?(node, children, ignore_last: false)
    if node.array_type?
      node.first_line == node.last_line
    else
      all_on_same_line?(children, ignore_last:)
    end
  end
end

RuboCop::Cop::MultilineElementLineBreaks.prepend(
  RungerStyle::MultilineElementLineBreaksPatches,
)
