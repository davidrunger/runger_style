# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class IfUnlessModifier < ::RuboCop::Cop::Base
    extend ::RuboCop::Cop::AutoCorrector
    include ::RuboCop::Cop::RangeHelp

    MSG = 'Use a multiline conditional instead of a trailing `%<keyword>s` condition.'

    def on_if(node)
      if node.modifier_form?
        comment = trailing_comment(node)

        add_offense(node.loc.keyword, message: format(MSG, keyword: node.keyword)) do |corrector|
          corrector.replace(node, replacement(node, comment))

          if comment
            corrector.remove(trailing_comment_range(node, comment))
          end
        end
      end
    end

    private

    def replacement(node, comment)
      indentation = node.source_range.source_line[/^\s*/]

      <<~RUBY.chomp
        #{node.keyword} #{node.condition.source}#{comment_suffix(comment)}
        #{indented_body(node, indentation)}
        #{indentation}end
      RUBY
    end

    def indented_body(node, indentation)
      node.body.source.lines.map.with_index do |line, index|
        index.zero? ? "#{indentation}  #{line}" : "  #{line}"
      end.join
    end

    def trailing_comment(node)
      processed_source.comments.find do |comment|
        comment.location.line == node.last_line &&
          comment.source_range.begin_pos >= node.source_range.end_pos
      end
    end

    def comment_suffix(comment)
      if comment
        " #{comment.source}"
      else
        ''
      end
    end

    def trailing_comment_range(node, comment)
      range_between(node.source_range.end_pos, comment.source_range.end_pos)
    end
  end
end
