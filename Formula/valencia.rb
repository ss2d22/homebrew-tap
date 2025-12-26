class Valencia < Formula
  desc "AI orchestrator for Claude Code - provides framework context and git automation"
  homepage "https://github.com/ss2d22/valencia-ai-orchestrator"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ss2d22/valencia-releases/releases/download/v0.1.0/valencia-darwin-aarch64"
      sha256 "SHA256_DARWIN_ARM64_PLACEHOLDER"
    end
    on_intel do
      url "https://github.com/ss2d22/valencia-releases/releases/download/v0.1.0/valencia-darwin-x86_64"
      sha256 "SHA256_DARWIN_X86_64_PLACEHOLDER"
    end
  end

  on_linux do
    url "https://github.com/ss2d22/valencia-releases/releases/download/v0.1.0/valencia-linux-x86_64"
    sha256 "SHA256_LINUX_X86_64_PLACEHOLDER"
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
