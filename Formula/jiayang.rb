class Jiayang < Formula
  desc "Deploy, share and audit apps on Jiayang Cloud"
  homepage "https://jiayang.cloud"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.2/jiayang-aarch64-apple-darwin.tar.xz"
      sha256 "f6e6bc21039586c2174249e22ad31bd913d0c8d96fb67d601bbf50bf30f762e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.2/jiayang-x86_64-apple-darwin.tar.xz"
      sha256 "748e72367cfc458fbd16669166eafa0a9fe9c50f866bfe6e2423e6b03c99558f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.2/jiayang-aarch64-unknown-linux-musl.tar.xz"
      sha256 "1f3fbea1724799196377f9227557bca0bca9fee3cb8f2b93e923aad4824b6a67"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.2/jiayang-x86_64-unknown-linux-musl.tar.xz"
      sha256 "a7eb98ea49765e3b3113dc8c42674e0193bb78b70c65707f62053425162dc60f"
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
