class Topgrade < Formula
  desc "Upgrade all the things"
  homepage "https://github.com/r-darwish/topgrade"
  url "https://github.com/r-darwish/topgrade/archive/v2.4.0.tar.gz"
  sha256 "b60516c1cab836ab88764a2073f3563180f6ae2af5c22b3b941df07e895209b5"

  bottle do
    cellar :any_skip_relocation
    sha256 "fd53280d27c8d952bcd0131bed94d9b877a3c9ba779a41476793b3a95ac1471c" => :mojave
    sha256 "106995c6f9deed2418c0e8035c09429e156fb2f03e303f7f6726de601a1df41b" => :high_sierra
    sha256 "4d5a581846697c85c9897beae5f8cce48973527a78d92c80481940eb8304cd56" => :sierra
    sha256 "032890fdbe4e00ebe3c0dcdbbe3239fcc9136afce75a95b3e995a65f5d2e41ba" => :x86_64_linux
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    output = shell_output("#{bin}/topgrade -n")
    assert_match "Dry running: #{HOMEBREW_PREFIX}/bin/brew upgrade", output
    assert_not_match /\sSelf update\s/, output
  end
end
