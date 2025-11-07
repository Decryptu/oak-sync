class OakSync < Formula
  desc "CLI tool for syncing Oak Research production branches with preprod"
  homepage "https://github.com/Decryptu/oak-sync"
  url "https://github.com/Decryptu/oak-sync/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "" # This will be calculated when you create a release
  license "MIT"

  depends_on "gum"

  def install
    bin.install "oak-sync"
  end

  test do
    # Test that the script exists and is executable
    assert_predicate bin/"oak-sync", :exist?
    assert_predicate bin/"oak-sync", :executable?

    # Test that gum dependency is available
    system "which", "gum"
  end
end
