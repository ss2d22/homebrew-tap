class Jiayang < Formula
  desc "Deploy private apps and share them by email, from a terminal or an AI agent"
  homepage "https://jiayang.cloud"
  version "0.1.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.13/jiayang-aarch64-apple-darwin.tar.xz"
      sha256 "c9d23bf6a1ca4268ebfbaa5470a6a379ea9e6e7b84d2d4e80700419b750c5eaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.13/jiayang-x86_64-apple-darwin.tar.xz"
      sha256 "4f63996e294a32f34640c46ebe740548ffba8f1573980925ba5b936e03e857b2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.13/jiayang-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c8db169c24cf408e195a6e2e71edd15af77a59ee28dd26ad138d88fbb1625298"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.13/jiayang-x86_64-unknown-linux-musl.tar.xz"
      sha256 "821c596df78b9fea65b1cf5b32f49b444855882a61c7ff24b9e486ab58fc4e22"
    end
  end
  # The jiayang CLI is proprietary, binaries only: https://jiayang.cloud/terms
  # The SDKs and the agent plugin in ss2d22/jiayang are Apache-2.0.
  license "LicenseRef-Proprietary"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
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
