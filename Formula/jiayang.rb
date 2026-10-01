class Jiayang < Formula
  desc "Deploy, share and audit apps on Jiayang Cloud"
  homepage "https://jiayang.cloud"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.3/jiayang-aarch64-apple-darwin.tar.xz"
      sha256 "bc7b634c07469323e3bd6dbf35d72408cafcd8be89aff341288751c6c833126e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.3/jiayang-x86_64-apple-darwin.tar.xz"
      sha256 "ef88784b5a44fb6c767b0ef3496d5df640e36f5bce4eb1b679ef4f7213ce14b6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.3/jiayang-aarch64-unknown-linux-musl.tar.xz"
      sha256 "be9dfdfc8f6124737a64fe04ef149bca4acd6b2098356ef462687df751825d09"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ss2d22/jiayang/releases/download/v0.1.3/jiayang-x86_64-unknown-linux-musl.tar.xz"
      sha256 "0e596cdfcefb7b67baa2b72b45e001419d59d9e974e10dd12ce226e8dbb9c7ee"
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
