class Preback < Formula
  include Language::Python::Virtualenv

  desc "Pre-Time-Machine cleanup CLI for macOS"
  homepage "https://github.com/scalinity/PreBack"
  # Bump on every release: change the tag in `url`, then run
  #   curl -sL <url> | shasum -a 256
  # and paste the result into `sha256` below.
  url "https://github.com/scalinity/PreBack/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_WITH_TARBALL_SHA256_AFTER_TAGGING_v0_1_0"
  license :cannot_represent  # pyproject.toml says "Proprietary (local use)"
  head "https://github.com/scalinity/PreBack.git", branch: "main"

  # macOS-only by design — preback wraps tmutil and Library/-rooted paths
  # that don't exist outside macOS. Pin the floor to whatever the
  # codebase actually supports today; bump if you start using newer
  # AppKit / system APIs.
  depends_on macos: :ventura
  depends_on "python@3.13"

  def install
    # preback's core (scan / plan / clean / exclusions / snapshots /
    # report) has zero third-party runtime deps — Python 3.13 stdlib
    # only — so `virtualenv_install_with_resources` works without a
    # `resource` block. If you later default to installing one of the
    # `[claude]` / `[openai]` / `[ai]` extras, regenerate the resource
    # block via `homebrew-pypi-poet preback` and paste it above.
    virtualenv_install_with_resources
  end

  test do
    # `preback --version` should print preback's version. We only
    # assert "preback" appears (case-insensitive) so a future format
    # tweak doesn't break the test.
    assert_match(/preback/i, shell_output("#{bin}/preback --version"))
    # `preback --help` should exit 0 — confirms the entry point wired
    # up by pyproject.toml's `[project.scripts]` is callable.
    system bin/"preback", "--help"
  end
end
