# Releasing

1. check out the `main` branch
2. update `CHANGELOG.md`
3. update the version number in `version.rb`
4. `bundle install` (which will update `Gemfile.lock`)
5. commit the changes with a message like `Prepare to release v0.1.1`
6. run `bin/release` (which will create a git tag for the version and push git commits and
   tags to GitHub)
