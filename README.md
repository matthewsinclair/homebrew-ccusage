# homebrew-ccusage

The Homebrew tap for [Ccusage](https://github.com/matthewsinclair/ccusage): a simple CLI for checking Claude Usage across multiple accounts.

```bash
brew install matthewsinclair/ccusage/ccusage
ccusage doctor
```

The formula builds from source at the release tag, on macOS (Apple Silicon and Intel). Its source of truth is `packaging/homebrew/ccusage.rb` in the Ccusage repository, where `tools/formula-bump` writes each release's tag and commit; it is copied here after each release.
