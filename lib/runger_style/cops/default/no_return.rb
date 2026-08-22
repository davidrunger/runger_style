# frozen_string_literal: true

module RungerStyle # rubocop:disable Style/ClassAndModuleChildren
  class NoReturn < ::RuboCop::Cop::Base
    MSG = 'Do not use `return`.'

    def on_return(node)
      add_offense(node.loc.keyword, message: MSG)
    end
  end
end
