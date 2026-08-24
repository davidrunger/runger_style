# frozen_string_literal: true

RSpec.describe RungerStyle::EmptyLineAfterMacro, :config do
  it 'accepts a macro call followed by the class-closing end' do
    expect_no_offenses(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        has_many :quiz_question_answer_selections
      end
    RUBY
  end

  it 'accepts a macro call separated from a method definition' do
    expect_no_offenses(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        has_many :quiz_question_answer_selections

        def correct_answer_count
          quiz_question_answer_selections.count { it.answer.is_correct? }
        end
      end
    RUBY
  end

  it 'accepts consecutive macro calls before a method definition' do
    expect_no_offenses(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        has_many :quiz_question_answer_selections
        belongs_to :something_else

        def correct_answer_count
          quiz_question_answer_selections.count { it.answer.is_correct? }
        end
      end
    RUBY
  end

  it 'accepts a self-receiver macro grouped with other macro calls' do
    expect_no_offenses(<<~RUBY)
      class EmojiPickerController < ApplicationController
        skip_before_action :authenticate_user!
        self.container_classes = %w[p-8]
        self.use_local_files ||= ::Rails.env.development?

        def index
          render :index
        end
      end
    RUBY
  end

  it 'does not group calls on other receivers with macro calls' do
    expect_offense(<<~RUBY)
      class EmojiPickerController < ApplicationController
        skip_before_action :authenticate_user!
        ^^^^^^^^^^^^^^^^^^ Add an empty line after a macro call.
        config.container_classes = %w[p-8]

        def index
          render :index
        end
      end
    RUBY

    expect_correction(<<~RUBY)
      class EmojiPickerController < ApplicationController
        skip_before_action :authenticate_user!

        config.container_classes = %w[p-8]

        def index
          render :index
        end
      end
    RUBY
  end

  it 'complains about and corrects a macro call before a method definition' do
    expect_offense(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        has_many :quiz_question_answer_selections
        ^^^^^^^^ Add an empty line after a macro call.
        def correct_answer_count
          quiz_question_answer_selections.count { it.answer.is_correct? }
        end
      end
    RUBY

    expect_correction(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        has_many :quiz_question_answer_selections

        def correct_answer_count
          quiz_question_answer_selections.count { it.answer.is_correct? }
        end
      end
    RUBY
  end

  it 'requires an empty line before other class-body code' do
    expect_offense(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        has_many :quiz_question_answer_selections
        ^^^^^^^^ Add an empty line after a macro call.
        ANSWER_COUNT = 1
      end
    RUBY

    expect_correction(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        has_many :quiz_question_answer_selections

        ANSWER_COUNT = 1
      end
    RUBY
  end

  it 'preserves a trailing comment on the macro call' do
    expect_offense(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        has_many :quiz_question_answer_selections # Associations
        ^^^^^^^^ Add an empty line after a macro call.
        def correct_answer_count
        end
      end
    RUBY

    expect_correction(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        has_many :quiz_question_answer_selections # Associations

        def correct_answer_count
        end
      end
    RUBY
  end

  it 'does not treat ordinary calls outside a class or module as macros' do
    expect_no_offenses(<<~RUBY)
      require 'runger_style'
      require 'rubocop'
    RUBY
  end

  it 'does not treat calls inside method bodies as macros' do
    expect_no_offenses(<<~RUBY)
      class QuizParticipation < ApplicationRecord
        def correct_answer_count
          configure
          result = 1
        end
      end
    RUBY
  end

  it 'does not treat setter calls inside instance methods as macros' do
    expect_no_offenses(<<~RUBY)
      class ApplicationCable::Connection < ActionCable::Connection::Base
        def connect
          self.current_user = find_verified_user
          AuthenticatedSessions::Registry.current(request.session, :user)
        end
      end
    RUBY
  end

  it 'does not treat setter calls inside singleton methods as macros' do
    expect_no_offenses(<<~RUBY)
      class ApplicationCable::Connection < ActionCable::Connection::Base
        def self.connect
          self.current_user = find_verified_user
          AuthenticatedSessions::Registry.current(request.session, :user)
        end
      end
    RUBY
  end

  it 'does not treat setter calls inside methods in a singleton class as macros' do
    expect_no_offenses(<<~RUBY)
      class ApplicationCable::Connection < ActionCable::Connection::Base
        class << self
          def connect
            self.current_user = find_verified_user
            AuthenticatedSessions::Registry.current(request.session, :user)
          end
        end
      end
    RUBY
  end
end
