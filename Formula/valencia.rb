class Valencia < Formula
  desc "AI orchestrator for Claude Code - provides framework context and git automation"
  homepage "https://github.com/ss2d22/valencia-ai-orchestrator"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/ss2d22/valencia-releases/releases/download/v0.4.0/valencia-darwin-aarch64"
      sha256 "d7bef2e7d91661a573a6ee3fbafb0cc8ca6a60d1d42de29c07293248bbdb83d7"
    end
    on_intel do
      url "https://github.com/ss2d22/valencia-releases/releases/download/v0.4.0/valencia-darwin-x86_64"
      sha256 "ed999bf9efe3df49c56e1d23da2ffde84b50f49e4867b5a1efc692c34acfdeb1"
    end
  end

  on_linux do
    url "https://github.com/ss2d22/valencia-releases/releases/download/v0.4.0/valencia-linux-x86_64"
    sha256 "11e401062421ee1d4bc69a7c551e86fb9247ca4afd256d780714e2e09eddf329"
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
