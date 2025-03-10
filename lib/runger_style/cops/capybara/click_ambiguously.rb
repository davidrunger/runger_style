# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class ClickAmbiguously < ::RuboCop::Cop::Base
    extend ::RuboCop::Cop::AutoCorrector
    MSG = 'Use `click_on` instead of `click_link` or `click_button`.'
    RESTRICT_ON_SEND = %i[click_button click_link].freeze

    def on_send(node)
      add_offense(node) do |corrector|
        corrector.replace(node.loc.selector, 'click_on')
      end
    end
  end
end
