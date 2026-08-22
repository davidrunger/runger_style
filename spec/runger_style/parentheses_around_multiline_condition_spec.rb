# frozen_string_literal: true

RSpec.describe RungerStyle::ParenthesesAroundMultilineCondition, :config do
  it 'accepts single-line conditions' do
    expect_no_offenses(<<~RUBY)
      if ready?
        start
      end

      unless stopped?
        continue
      end

      if ready?
        start
      elsif stopped?
        stop
      end
    RUBY
  end

  it 'accepts multiline conditions with the condition on the next line' do
    expect_no_offenses(<<~RUBY)
      if (
        normalized_url &&
          visited_sitemap_urls.exclude?(normalized_url)
      )
        visited_sitemap_urls.add(normalized_url)
      end

      unless (
        normalized_url &&
          visited_sitemap_urls.exclude?(normalized_url)
      )
        visited_sitemap_urls.add(normalized_url)
      end

      if ready?
        visit
      elsif (
        normalized_url &&
          visited_sitemap_urls.exclude?(normalized_url)
      )
        visited_sitemap_urls.add(normalized_url)
      end
    RUBY
  end

  it 'accepts a multiline parenthesized receiver in a condition' do
    expect_no_offenses(<<~RUBY)
      if (
        auth_token = potentially_unauthorized_auth_token_matching_secret
      )&.valid_for?(controller_action)
        auth_token
      end
    RUBY
  end

  it 'accepts a multiline block as a condition' do
    expect_no_offenses(<<~RUBY)
      if examples.any? do |example|
        example.metadata[:type] == :feature && !example.metadata[:rack_test_driver]
      end
        prewarm_driver(Cuprite::CustomDrivers::DOMAIN_RESTRICTED_CUPRITE)
      end
    RUBY
  end

  it 'wraps a multiline if condition in parentheses' do
    expect_offense(<<~RUBY)
      if normalized_url &&
      ^^ Wrap multiline `if` conditions in parentheses.
          visited_sitemap_urls.exclude?(normalized_url)
        visited_sitemap_urls.add(normalized_url)
      end
    RUBY

    expect_correction(<<~RUBY)
      if (
        normalized_url &&
          visited_sitemap_urls.exclude?(normalized_url)
      )
        visited_sitemap_urls.add(normalized_url)
      end
    RUBY
  end

  it 'wraps multiline unless and elsif conditions in parentheses' do
    expect_offense(<<~RUBY)
      unless normalized_url &&
      ^^^^^^ Wrap multiline `unless` conditions in parentheses.
          visited_sitemap_urls.exclude?(normalized_url)
        visited_sitemap_urls.add(normalized_url)
      end

      if ready?
        visit
      elsif normalized_url &&
      ^^^^^ Wrap multiline `elsif` conditions in parentheses.
          visited_sitemap_urls.exclude?(normalized_url)
        visited_sitemap_urls.add(normalized_url)
      end
    RUBY

    expect_correction(<<~RUBY)
      unless (
        normalized_url &&
          visited_sitemap_urls.exclude?(normalized_url)
      )
        visited_sitemap_urls.add(normalized_url)
      end

      if ready?
        visit
      elsif (
        normalized_url &&
          visited_sitemap_urls.exclude?(normalized_url)
      )
        visited_sitemap_urls.add(normalized_url)
      end
    RUBY
  end

  it 'puts an existing pair of parentheses around a multiline condition on separate lines' do
    expect_offense(<<~RUBY)
      if (normalized_url &&
      ^^ Wrap multiline `if` conditions in parentheses.
          visited_sitemap_urls.exclude?(normalized_url))
        visited_sitemap_urls.add(normalized_url)
      end
    RUBY

    expect_correction(<<~RUBY)
      if (
        normalized_url &&
          visited_sitemap_urls.exclude?(normalized_url)
      )
        visited_sitemap_urls.add(normalized_url)
      end
    RUBY
  end

  it 'places the closing parenthesis after a trailing condition comment' do
    expect_offense(<<~RUBY)
      if normalized_url &&
      ^^ Wrap multiline `if` conditions in parentheses.
          visited_sitemap_urls.exclude?(normalized_url) # already normalized
        visited_sitemap_urls.add(normalized_url)
      end
    RUBY

    expect_correction(<<~RUBY)
      if (
        normalized_url &&
          visited_sitemap_urls.exclude?(normalized_url) # already normalized
      )
        visited_sitemap_urls.add(normalized_url)
      end
    RUBY
  end
end
