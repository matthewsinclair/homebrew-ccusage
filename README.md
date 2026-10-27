# homebrew-ccusage

The Homebrew tap for [Ccusage](https://github.com/matthewsinclair/ccusage): named Claude Code accounts and a compact terminal usage dashboard.

```sh
brew install matthewsinclair/ccusage/ccusage
ccusage doctor
```

Supports Homebrew on macOS (Apple Silicon and Intel) and Linux (ARM64 and x86-64). The formula builds from source using Rust and Cargo.lock, pinned to a release tag and its exact commit. Claude Code must be installed separately and available as `claude` on `PATH`; it is not needed to install or test the formula.

```sh
ccusage init
ccusage add work --email you@example.com
ccusage login work
ccusage use work
ccusage usage --all
ccusage tui
```

Installation and upgrades preserve existing credentials, XDG directories, and shell configuration. `ccusage doctor` checks the environment and private-file permissions without reading credentials or querying usage.

The formula's source of truth is `packaging/homebrew/ccusage.rb` in the [Ccusage repository](https://github.com/matthewsinclair/ccusage). Its `tools/formula` command renders the release tag and commit and publishes updates here. See the [release instructions](https://github.com/matthewsinclair/ccusage/blob/main/docs/releasing.md).

Prebuilt macOS and Linux binaries, with checksums, are also available on [GitHub Releases](https://github.com/matthewsinclair/ccusage/releases).
