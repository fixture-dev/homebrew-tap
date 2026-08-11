class Lash < Formula
  desc "Minimalist, Markdown-native task tracker for devs and agents"
  homepage "https://github.com/fixture-dev/lash"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.3.1/lash-aarch64-apple-darwin.tar.xz"
      sha256 "5d18455a9643ffefc78ed4771c5de42a91a74ed13e9412fe80733f9962672800"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.3.1/lash-x86_64-apple-darwin.tar.xz"
      sha256 "8f1efa87d0fb5d10689d3dc87795936a2cfca118fc2acdb744e744e7ce2f66b4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.3.1/lash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "552d8cbb2852e1ce73bfb7e34e6347dbc96edc14d682ed56b0c20f0c15c27d6a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.3.1/lash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9361c01b60cca0e385a05ce2082e2e1325f2dfc5b44e201122eeeb8723ad289a"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
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
      bin.install "lash"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lash"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "lash"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lash"
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
