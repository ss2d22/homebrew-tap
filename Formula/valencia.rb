class Valencia < Formula
  desc "AI orchestrator for Claude Code - provides framework context and git automation"
  homepage "https://github.com/ss2d22/valencia-ai-orchestrator"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ss2d22/valencia-releases/releases/download/v0.5.0/valencia-darwin-aarch64"
      sha256 "97e149ef8e29f568013d33595d4e2e75cc5f55da9798120df88af45a8629af82"
    end
    on_intel do
      url "https://github.com/ss2d22/valencia-releases/releases/download/v0.5.0/valencia-darwin-x86_64"
      sha256 "3849c301e711c9ddbd631e9ce65263933ebd06eb04def42a16e74090971bc1e5"
    end
  end

  on_linux do
    url "https://github.com/ss2d22/valencia-releases/releases/download/v0.5.0/valencia-linux-x86_64"
    sha256 "dedd658718358d030c3ae9b66009f3df9107e6ac923beff172da58a1b824c525"
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
