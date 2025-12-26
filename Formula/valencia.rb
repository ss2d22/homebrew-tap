class Valencia < Formula
  desc "AI orchestrator for Claude Code - provides framework context and git automation"
  homepage "https://github.com/ss2d22/valencia-ai-orchestrator"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ss2d22/valencia-releases/releases/download/v0.6.0/valencia-darwin-aarch64"
      sha256 "1d804a9bba1a0b2d82551ff7588cc9a2e9eda019efce7bfcdcec112f7f82d597"
    end
    on_intel do
      url "https://github.com/ss2d22/valencia-releases/releases/download/v0.6.0/valencia-darwin-x86_64"
      sha256 "f5484fc662111b917d7c255abd0498bf422dfce417ef2e6f85adc3e0f35d0507"
    end
  end

  on_linux do
    url "https://github.com/ss2d22/valencia-releases/releases/download/v0.6.0/valencia-linux-x86_64"
    sha256 "ccbda1afb560e3c77c57a1f63324aee8ae21f40acded57fc66a8c160b3cbff3b"
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "valencia-darwin-aarch64" => "valencia"
      else
        bin.install "valencia-darwin-x86_64" => "valencia"
      end
    else
      bin.install "valencia-linux-x86_64" => "valencia"
    end
  end

  test do
    assert_match "valencia", shell_output("#{bin}/valencia --version")
  end
end
