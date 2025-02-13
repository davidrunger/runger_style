# frozen_string_literal: true

require 'rubocop'
require 'rubocop/rspec/support'

RSpec.describe RungerStyle::MultilineHashValueIndentation, :config do
  ruby_version =
    YAML.load_file(
      'rulesets/default.yml',
      permitted_classes: [Regexp],
    ).dig('AllCops', 'TargetRubyVersion')

  context "when the Ruby version is #{ruby_version}" do
    let(:ruby_version) { ruby_version }

    context 'when the hash key and value are on the same line' do
      it 'does not register an offense' do
        expect_no_offenses(<<~RUBY)
          bootstrap(gantt_chart_data_by_github_run_id: @ci_step_results_presenter.gantt_chart_metadatas)
        RUBY
      end
    end

    context 'when the hash value is correctly indented' do
      it 'does not register an offense' do
        expect_no_offenses(<<~RUBY)
          bootstrap(
            gantt_chart_data_by_github_run_id:
              @ci_step_results_presenter.gantt_chart_metadatas,
          )
        RUBY
      end
    end

    context 'when the hash value is indented too little' do
      it 'registers an offense and autocorrects it' do
        expect_offense(<<~RUBY)
          bootstrap(
            gantt_chart_data_by_github_run_id:
            @ci_step_results_presenter.gantt_chart_metadatas,
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Hash value should be indented by two spaces relative to its key.
          )
        RUBY

        expect_correction(<<~RUBY)
          bootstrap(
            gantt_chart_data_by_github_run_id:
              @ci_step_results_presenter.gantt_chart_metadatas,
          )
        RUBY
      end
    end

    context 'when the hash value is indented too much' do
      it 'registers an offense and autocorrects it' do
        expect_offense(<<~RUBY)
          bootstrap(
            gantt_chart_data_by_github_run_id:
                @ci_step_results_presenter.gantt_chart_metadatas,
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Hash value should be indented by two spaces relative to its key.
          )
        RUBY

        expect_correction(<<~RUBY)
          bootstrap(
            gantt_chart_data_by_github_run_id:
              @ci_step_results_presenter.gantt_chart_metadatas,
          )
        RUBY
      end
    end

    context 'when the hash value is a method call' do
      it 'registers an offense and indents the first line of the method call' do
        expect_offense(<<~RUBY)
          bootstrap(
            gantt_chart_data_by_github_run_id:
            some_other_method(
            ^^^^^^^^^^^^^^^^^^ Hash value should be indented by two spaces relative to its key.
              an_argument,
            )
          )
        RUBY

        # NOTE: This autocorrection is imperfect, but it will be further improved by other cops.
        expect_correction(<<~RUBY)
          bootstrap(
            gantt_chart_data_by_github_run_id:
              some_other_method(
              an_argument,
            )
          )
        RUBY
      end
    end

    context 'when the key is multiline but the value is single-line' do
      it 'does not register an offense' do
        expect_no_offenses(<<~RUBY)
          SPEC_TO_RAILS_DEFAULT_MAP = {
            %r{
              actions|
              workers
            }x => 'app/\1/',
          }.freeze
        RUBY
      end
    end

    context 'when the key is multiline and the value is on another line' do
      it 'registers an offense and autocorrects it' do
        expect_offense(<<~RUBY)
          SPEC_TO_RAILS_DEFAULT_MAP = {
            %r{
              actions|
              workers
            }x =>
            'the hash value',
            ^^^^^^^^^^^^^^^^ Hash value should be indented by two spaces relative to its key.
          }.freeze
        RUBY

        expect_correction(<<~RUBY)
          SPEC_TO_RAILS_DEFAULT_MAP = {
            %r{
              actions|
              workers
            }x =>
              'the hash value',
          }.freeze
        RUBY
      end
    end
  end
end
