class FlashNotify < Formula
  desc "Flash macOS menu bar notification tool"
  homepage "https://github.com/shunsuke1980/flash_notify"
  url "https://github.com/shunsuke1980/flash_notify/archive/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  version "1.0.0"

  depends_on :macos

  def install
    bin.install "flash_notify"
  end

  test do
    # Test version output
    assert_match "flash_notify version #{version}", shell_output("#{bin}/flash_notify --version")

    # Test help output
    assert_match "Flash macOS menu bar notification tool", shell_output("#{bin}/flash_notify --help")

    # Test that the script exists and is executable
    assert_predicate bin/"flash_notify", :exist?
    assert_predicate bin/"flash_notify", :executable?
  end

  def caveats
    <<~EOS
      flash_notify requires permission to control System Events.

      On first run, macOS may prompt you to grant permission.
      If flash_notify doesn't work, check System Preferences:
        Security & Privacy > Privacy > Accessibility

      Make sure your terminal application has permission to control System Events.
    EOS
  end
end