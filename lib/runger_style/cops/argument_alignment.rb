# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class ArgumentAlignment < ::RuboCop::Cop::Layout::ArgumentAlignment
    def on_send(node)
      return if node.macro? && !node.parenthesized_call?

      super
    end
  end
end
