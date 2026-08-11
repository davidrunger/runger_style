# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Layout::LineLength, :config do
  let(:cop_config) do
    YAML.load_file(
      'rulesets/default.yml',
      permitted_classes: [Regexp],
    ).fetch(described_class.cop_name)
  end

  it 'allows a long AnnotateRb comment for a custom partial index' do
    expect_no_offenses(<<~RUBY)
      #  uniq_pending_proposals  (proposer_id,proposee_email) UNIQUE WHERE ((accepted_at IS NULL) AND (canceled_at IS NULL))
    RUBY
  end

  it 'allows a long AnnotateRb comment for a regular index' do
    expect_no_offenses(<<~RUBY)
      #  index_proposals_on_proposer_id_and_proposee_email_and_created_at (proposer_id,proposee_email,created_at)
    RUBY
  end

  it 'does not allow an index-like comment with only one space after the comment marker' do
    expect_offense(<<~RUBY)
      # index_proposals_on_proposer_id_and_proposee_email_and_created_at  (proposer_id,proposee_email,created_at)
                                                                                                          ^^^^^^^ Line is too long. [107/100]
    RUBY
  end

  it 'does not allow an unrelated long comment' do
    expect_offense(<<~RUBY)
      # This unrelated prose comment is intentionally made longer than one hundred characters so that it remains an offense.
                                                                                                          ^^^^^^^^^^^^^^^^^^ Line is too long. [118/100]
    RUBY
  end
end
