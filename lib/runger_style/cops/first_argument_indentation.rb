# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class FirstArgumentIndentation < ::RuboCop::Cop::Layout::FirstArgumentIndentation
    def on_send(node)
      return if memoizing?(node)

      super
    end

    private

    def memoizing?(node)
      memoizing_method_names.include?(node.method_name)
    end

    def memoizing_method_names
      @memoizing_method_names ||= cop_config['MemoizingMethods'].map(&:to_sym)
    end
  end
end
