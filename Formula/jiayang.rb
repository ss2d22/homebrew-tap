class Jiayang < Formula
  desc "Deploy, share and audit apps on Jiayang Cloud"
  homepage "https://jiayang.cloud"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.0/jiayang-aarch64-apple-darwin.tar.xz"
      sha256 "df02cb85f138fc16d9a5c3e5082a8ae1cb92485000ae93269bdbb28d6ddff452"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.0/jiayang-x86_64-apple-darwin.tar.xz"
      sha256 "1ab52fb8cd6a49ad1aa9b04037a8ff9c314ec2eb2f0f20d5732142d1e7def907"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.0/jiayang-aarch64-unknown-linux-musl.tar.xz"
      sha256 "21ebf1b1a1d0475b9b39ff2a0da4c33d85bc4c21be9fa8cc5308c95560ddeebf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.0/jiayang-x86_64-unknown-linux-musl.tar.xz"
      sha256 "dbc950eaa135dc257b0461213b1d7e1543a250ef99328a17b711d45f4003b2ed"
    end
  end
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
