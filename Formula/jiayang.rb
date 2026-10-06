class Jiayang < Formula
  desc "Deploy, share and audit apps on Jiayang Cloud"
  homepage "https://jiayang.cloud"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.10/jiayang-aarch64-apple-darwin.tar.xz"
      sha256 "8e880edec0af1f6f9c03aa48601c00f6ac52bfd16154657b1ce275cccdfe22d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.10/jiayang-x86_64-apple-darwin.tar.xz"
      sha256 "151e71732e0490102455459a6cfe39c1b0271a7337cbf04324375fb4b2396da9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.10/jiayang-aarch64-unknown-linux-musl.tar.xz"
      sha256 "27aca2b39a906c789586e6cb9054106dfe7e59c904161dc73726919f05bf8546"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.10/jiayang-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f4be92492716fd9fe2c649d2e13a201e8f87e6ddf4bfd3e55e97946a877e8af9"
    end
  end
  # The jiayang CLI is proprietary, binaries only: https://jiayang.cloud/terms
  # The SDKs and the agent plugin in ss2d22/jiayang are Apache-2.0.
  license "LicenseRef-Proprietary"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "jiayang"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jiayang"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jiayang"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jiayang"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
