# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class ArgumentAlignment < ::RuboCop::Cop::Layout::ArgumentAlignment
    def on_send(node)
      previous_fixed_indentation = @fixed_indentation
      @fixed_indentation = node.macro? && !node.parenthesized_call?

      super
    ensure
      @fixed_indentation = previous_fixed_indentation
    end

    private

    def fixed_indentation?
      @fixed_indentation || super
    end

    def with_first_argument_style?
      !@fixed_indentation && super
    end
  end
end
