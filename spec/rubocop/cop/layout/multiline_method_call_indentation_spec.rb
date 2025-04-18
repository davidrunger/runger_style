# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Layout::MultilineMethodCallIndentation, :config do
  let(:config) do
    merged = RuboCop::ConfigLoader.
      default_configuration['Layout/MultilineMethodCallIndentation'].
      merge(cop_config).
      merge('IndentationWidth' => cop_indent)
    RuboCop::Config.
      new('Layout/MultilineMethodCallIndentation' => merged,
          'Layout/IndentationWidth' => { 'Width' => indentation_width })
  end
  let(:indentation_width) { 2 }
  let(:cop_indent) { nil } # use indentation width from Layout/IndentationWidth

  shared_examples 'common' do
    it 'accepts indented methods in LHS of []= assignment' do
      expect_no_offenses(<<~RUBY)
        a
          .b[c] = 0
      RUBY
    end

    it 'accepts indented methods inside and outside a block' do
      expect_no_offenses(<<~RUBY)
        a = b.map do |c|
          c
            .b
            .d do
              x
                .y
            end
        end
      RUBY
    end

    it 'accepts indentation relative to first receiver' do
      expect_no_offenses(<<~RUBY)
        node
          .children.map { |n| string_source(n) }.compact
          .any? { |s| preferred.any? { |d| s.include?(d) } }
      RUBY
    end

    it 'accepts indented methods in ordinary statement' do
      expect_no_offenses(<<~RUBY)
        a.
          b
      RUBY
    end

    it 'accepts no extra indentation of third line' do
      expect_no_offenses(<<~RUBY)
        a.
          b.
          c
      RUBY
    end

    it 'accepts indented methods in for body' do
      expect_no_offenses(<<~RUBY)
        for x in a
          something.
            something_else
        end
      RUBY
    end

    it 'accepts alignment inside a grouped expression' do
      expect_no_offenses(<<~RUBY)
        (a.
         b)
      RUBY
    end

    it 'accepts arithmetic operation with block inside a grouped expression' do
      expect_no_offenses(<<~RUBY)
        (
          a * b do
          end
        )
          .c
      RUBY
    end

    it 'accepts an expression where the first method spans multiple lines' do
      expect_no_offenses(<<~RUBY)
        subject.each do |item|
          result = resolve(locale) and return result
        end.a
      RUBY
    end

    it 'accepts any indentation of parameters to #[]' do
      expect_no_offenses(<<~RUBY)
        payment = Models::IncomingPayments[
                id:      input['incoming-payment-id'],
                   user_id: @user[:id]]
      RUBY
    end

    it 'accepts aligned methods when multiline method chain with a block argument and method chain' do
      expect_no_offenses(<<~RUBY)
        a(b)
          .c(
            d do
            end.f
          )
      RUBY
    end

    it "doesn't crash on unaligned multiline lambdas" do
      expect_no_offenses(<<~RUBY)
        MyClass.(my_args)
          .my_method
      RUBY
    end

    it 'accepts alignment of method with assignment and operator-like method' do
      expect_no_offenses(<<~RUBY)
        query = x.|(
          foo,
          bar
        )
      RUBY
    end
  end

  shared_examples 'common for aligned and indented' do
    it 'accepts even indentation of consecutive lines in typical RSpec code' do
      expect_no_offenses(<<~RUBY)
        expect { Foo.new }.
          to change { Bar.count }.
          from(1).to(2)
      RUBY
    end

    it 'registers an offense and corrects no indentation of second line' do
      expect_offense(<<~RUBY)
        a.
        b
        ^ Use 2 (not 0) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        a.
          b
      RUBY
    end

    it 'registers an offense and corrects 3 spaces indentation of 2nd line' do
      expect_offense(<<~RUBY)
        a.
           b
           ^ Use 2 (not 3) spaces for indenting an expression spanning multiple lines.
        c.
           d
           ^ Use 2 (not 3) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        a.
          b
        c.
          d
      RUBY
    end

    it 'registers an offense and corrects extra indentation of third line' do
      expect_offense(<<~RUBY)
        a.
          b.
            c
            ^ Use 2 (not 4) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        a.
          b.
          c
      RUBY
    end

    it 'registers an offense and corrects the emacs ruby-mode 1.1 ' \
       'indentation of an expression in an array' do
         expect_offense(<<~RUBY)
           [
            a.
            b
            ^ Use 2 (not 0) spaces for indenting an expression spanning multiple lines.
           ]
         RUBY

         expect_correction(<<~RUBY)
           [
            a.
              b
           ]
         RUBY
       end

    it 'registers an offense and corrects extra indentation of 3rd line in typical RSpec code' do
      expect_offense(<<~RUBY)
        expect { Foo.new }.
          to change { Bar.count }.
              from(1).to(2)
              ^^^^ Use 2 (not 6) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        expect { Foo.new }.
          to change { Bar.count }.
          from(1).to(2)
      RUBY
    end

    it 'registers an offense and corrects proc call without a selector' do
      expect_offense(<<~RUBY)
        a
         .(args)
         ^^ Use 2 (not 1) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        a
          .(args)
      RUBY
    end

    it 'registers an offense and corrects one space indentation of 2nd line' do
      expect_offense(<<~RUBY)
        a
         .b
         ^^ Use 2 (not 1) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        a
          .b
      RUBY
    end

    context 'when using safe navigation operator' do
      it 'registers an offense and corrects no indentation of second line' do
        expect_offense(<<~RUBY)
          a&.
          b
          ^ Use 2 (not 0) spaces for indenting an expression spanning multiple lines.
        RUBY

        expect_correction(<<~RUBY)
          a&.
            b
        RUBY
      end

      it 'registers an offense and corrects 3 spaces indentation of 2nd line' do
        expect_offense(<<~RUBY)
          a&.
             b
             ^ Use 2 (not 3) spaces for indenting an expression spanning multiple lines.
          c&.
             d
             ^ Use 2 (not 3) spaces for indenting an expression spanning multiple lines.
        RUBY

        expect_correction(<<~RUBY)
          a&.
            b
          c&.
            d
        RUBY
      end

      it 'registers an offense and corrects extra indentation of third line' do
        expect_offense(<<~RUBY)
          a&.
            b&.
              c
              ^ Use 2 (not 4) spaces for indenting an expression spanning multiple lines.
        RUBY

        expect_correction(<<~RUBY)
          a&.
            b&.
            c
        RUBY
      end

      it 'registers an offense and corrects the emacs ruby-mode 1.1 ' \
         'indentation of an expression in an array' do
           expect_offense(<<~RUBY)
             [
              a&.
              b
              ^ Use 2 (not 0) spaces for indenting an expression spanning multiple lines.
             ]
           RUBY

           expect_correction(<<~RUBY)
             [
              a&.
                b
             ]
           RUBY
         end

      it 'registers an offense and corrects extra indentation of 3rd line in typical RSpec code' do
        expect_offense(<<~RUBY)
          expect { Foo.new }&.
            to change { Bar.count }&.
                from(1)&.to(2)
                ^^^^ Use 2 (not 6) spaces for indenting an expression spanning multiple lines.
        RUBY

        expect_correction(<<~RUBY)
          expect { Foo.new }&.
            to change { Bar.count }&.
            from(1)&.to(2)
        RUBY
      end

      it 'registers an offense and corrects proc call without a selector' do
        expect_offense(<<~RUBY)
          a
           &.(args)
           ^^^ Use 2 (not 1) spaces for indenting an expression spanning multiple lines.
        RUBY

        expect_correction(<<~RUBY)
          a
            &.(args)
        RUBY
      end

      it 'registers an offense and corrects one space indentation of 2nd line' do
        expect_offense(<<~RUBY)
          a
           &.b
           ^^^ Use 2 (not 1) spaces for indenting an expression spanning multiple lines.
        RUBY

        expect_correction(<<~RUBY)
          a
            &.b
        RUBY
      end

      it 'accepts aligned methods when multiline method chain with a block argument and method chain' do
        expect_no_offenses(<<~RUBY)
          a&.(b)
            .c(
              d do
              end.f
            )
        RUBY
      end

      it "doesn't crash on multiline method calls with safe navigation and assignment" do
        expect_offense(<<~RUBY)
          MyClass.
          foo&.bar = 'baz'
          ^^^ Use 2 (not 0) spaces for indenting an expression spanning multiple lines.
        RUBY

        expect_correction(<<~RUBY)
          MyClass.
            foo&.bar = 'baz'
        RUBY
      end
    end
  end

  shared_examples 'both indented* styles' do
    # We call it semantic alignment when a dot is aligned with the first dot in
    # a chain of calls, and that first dot does not begin its line. But for the
    # indented style, it doesn't come into play.
    context 'when for possible semantic alignment' do
      it 'accepts indented methods' do
        expect_no_offenses(<<~RUBY)
          User.a
            .c
            .b
        RUBY
      end
    end
  end

  context 'when EnforcedStyle is indented_relative_to_receiver' do
    let(:cop_config) { { 'EnforcedStyle' => 'indented_relative_to_receiver' } }

    it_behaves_like 'common'
    it_behaves_like 'both indented* styles'

    it 'requires indentation of a chained multiline method call used as a method argument' do
      expect_offense(<<~RUBY)
        a(
          b.
          c
          ^ Use 2 (not 0) spaces for indenting an expression spanning multiple lines.
        )
      RUBY

      expect_correction(<<~RUBY)
        a(
          b.
            c
        )
      RUBY
    end

    it 'accepts indentation relative to immediate receiver in a chained multiline method call used as a method argument' do
      expect_no_offenses(<<~RUBY)
        foo.
          bar(
            baz.
              qux.
              lux,
          )
      RUBY
    end

    it 'accepts indentation relative to immediate receiver in a chained multiline method call used as a method argument even there is a subsequent method call chained to an outer layer' do
      expect_no_offenses(<<~RUBY)
        perform_async(
          log_entry.
            merge(
              log_entry.
                slice,
            ).
            to_json,
        )
      RUBY
    end

    it 'makes an exception for indentation of consecutive lines in typical RSpec code (with no parens around multiline arguments to `to`)' do
      expect_no_offenses(<<~RUBY)
        expect { Foo.new }.
          noparens change { Bar.count }.
          from(1).new_value(2)
      RUBY
    end

    ruby_version =
      YAML.load_file(
        'rulesets/default.yml',
        permitted_classes: [Regexp],
      ).dig('AllCops', 'TargetRubyVersion')

    context "when the Ruby version is #{ruby_version}" do
      let(:ruby_version) { ruby_version }

      it 'accepts indentation relative to the receiver in a method call' do
        expect_no_offenses(<<~RUBY)
          def user_ratings_of_partner
            NeedSatisfactionRatingSerializer.new(
              check_in.need_satisfaction_ratings.
                where(user:).
                includes(:emotional_need).
                order('emotional_needs.name'),
            )
          end
        RUBY
      end
    end

    it "doesn't fail on unary operators" do
      expect_offense(<<~RUBY)
        def foo
          !0
          .nil?
          ^^^^^ Use 2 (not 0) spaces for indenting an expression spanning multiple lines.
        end
      RUBY
    end

    it 'accepts correctly indented methods in operation' do
      expect_no_offenses(<<~RUBY)
        1 + a
          .b
          .c
      RUBY
    end

    it 'accepts indentation of consecutive lines in typical RSpec code' do
      expect_no_offenses(<<~RUBY)
        expect { Foo.new }.to change { Bar.count }
          .from(1).to(2)
      RUBY
    end

    it 'registers an offense and corrects no indentation of second line' do
      expect_offense(<<~RUBY)
        a.
        b
        ^ Use 2 (not 0) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        a.
          b
      RUBY
    end

    it 'registers an offense and corrects extra indentation of 3rd line in typical RSpec code' do
      expect_offense(<<~RUBY)
        expect { Foo.new }.
          to change { Bar.count }.
              from(1).to(2)
              ^^^^ Use 2 (not 6) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        expect { Foo.new }.
          to change { Bar.count }.
          from(1).to(2)
      RUBY
    end

    it 'registers an offense and corrects proc call without a selector' do
      expect_offense(<<~RUBY)
        a
         .(args)
         ^^ Indent `.(` 2 spaces more than `a` on line 1.
      RUBY

      expect_correction(<<~RUBY)
        a
          .(args)
      RUBY
    end

    it 'does not register an offense when multiline method chain has expected indent width and ' \
       'the method is preceded by splat' do
         expect_no_offenses(<<~RUBY)
           [
             *foo
               .bar(
                 arg)
           ]
         RUBY
       end

    it 'does not register an offense when multiline method chain has expected indent width and ' \
       'the method is preceded by double splat' do
         expect_no_offenses(<<~RUBY)
           [
             **foo
               .bar(
                 arg)
           ]
         RUBY
       end

    it 'registers an offense and corrects one space indentation of 2nd line' do
      expect_offense(<<~RUBY)
        a
         .b
         ^^ Use 2 (not 1) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        a
          .b
      RUBY
    end

    it 'registers an offense and corrects 3 spaces indentation of second line' do
      expect_offense(<<~RUBY)
        a.
           b
           ^ Use 2 (not 3) spaces for indenting an expression spanning multiple lines.
        c.
           d
           ^ Use 2 (not 3) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        a.
          b
        c.
          d
      RUBY
    end

    it 'registers an offense and corrects extra indentation of 3rd line' do
      expect_offense(<<~RUBY)
        a.
          b.
            c
            ^ Use 2 (not 4) spaces for indenting an expression spanning multiple lines.
      RUBY

      expect_correction(<<~RUBY)
        a.
          b.
          c
      RUBY
    end

    it 'registers an offense and corrects the emacs ruby-mode 1.1 ' \
       'indentation of an expression in an array' do
         expect_offense(<<~RUBY)
           [
            a.
            b
            ^ Use 2 (not 0) spaces for indenting an expression spanning multiple lines.
           ]
         RUBY

         expect_correction(<<~RUBY)
           [
            a.
              b
           ]
         RUBY
       end
  end
end
