# Canonical template. Render using tools/formula render TAG OUTPUT.
# The tag and its commit are resolved together; never fill these in by hand.
class Ccusage < Formula
  desc "Named Claude Code accounts and a terminal usage dashboard"
  homepage "https://github.com/matthewsinclair/ccusage"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/matthewsinclair/ccusage/releases/download/v0.1.5/ccusage-v0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "f4e7a1d04807bf203bef5ef0dc1c1efc996ce508129dad474790920b1a51ad35"
    end
    on_intel do
      url "https://github.com/matthewsinclair/ccusage/releases/download/v0.1.5/ccusage-v0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "f3b5f8310f7d5bd08fcf28293531b258f80dc18c567e424dda5dd47ddb68553b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/matthewsinclair/ccusage.git",
          tag:      "v0.1.5",
          revision: "7b58078f96fd6a345c5e8b4271b2fe38a02e0673"
    end
    on_intel do
      url "https://github.com/matthewsinclair/ccusage.git",
          tag:      "v0.1.5",
          revision: "7b58078f96fd6a345c5e8b4271b2fe38a02e0673"
    end
    depends_on "rust" => :build
  end

  def install
    if OS.mac?
      bin.install "ccusage"
      verify_macos_signature
      pkgshare.install "ccusage-logo.svg"
    else
      system "cargo", "install", *std_cargo_args
      pkgshare.install "design/icons/ccusage-logo.svg"
    end
  end

  def verify_macos_signature
    requirement = '=identifier "com.geodica.ccusage" and anchor apple generic ' \
                  'and certificate leaf[subject.OU] = "76BQL8L47U" ' \
                  "and certificate leaf[field.1.2.840.113635.100.6.1.13] exists"
    system "/usr/bin/codesign", "--verify", "--strict", "-R", requirement, bin/"ccusage"
  end

  def caveats
    <<~EOS
      Install Claude Code separately and make sure claude is on PATH.
      Check your environment with: ccusage doctor
      Set up accounts with: ccusage init
      Existing credentials and XDG configuration are preserved on upgrades.
      macOS may request Keychain access once per account when moving to signed releases.
    EOS
  end

  test do
    if OS.mac?
      verify_macos_signature
    end
    assert_match "ccusage #{version}", shell_output("#{bin}/ccusage --version")
    assert_match "PLAN USAGE", shell_output("#{bin}/ccusage usage --demo")
    ENV["XDG_CONFIG_HOME"] = (testpath/"config").to_s
    system bin/"ccusage", "init"
    system bin/"ccusage", "add", "example"
    assert_path_exists testpath/"config/ccusage/config.toml"
  end
end
