class Jiayang < Formula
  desc "Deploy, share and audit apps on Jiayang Cloud"
  homepage "https://jiayang.cloud"
  version "0.1.11"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.11/jiayang-aarch64-apple-darwin.tar.xz"
      sha256 "82178b0a6d5ad6794290adb327fe9522dfa57eab2e199e73578f5cc7d1327b39"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.11/jiayang-x86_64-apple-darwin.tar.xz"
      sha256 "47eff2b165a37ac69bea443c8f38d2590581e381d7c87ccf35be6cf03451b7c1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.11/jiayang-aarch64-unknown-linux-musl.tar.xz"
      sha256 "93fc193cdbffb7246bed63b201df1ddd1d9407989282d35d4d14ac6636885361"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.11/jiayang-x86_64-unknown-linux-musl.tar.xz"
      sha256 "84b5cae7d3030ee9e7a5e7e66f74445d13335a3c795e5573107641a14c8b4c85"
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
