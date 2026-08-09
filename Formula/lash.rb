class Lash < Formula
  desc "Minimalist, Markdown-native task tracker for devs and agents"
  homepage "https://github.com/fixture-dev/lash"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.3.0/lash-aarch64-apple-darwin.tar.xz"
      sha256 "c00441965b5ef195573d4ed49d32745fc89bc97aa9540acf143bccaa34789121"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.3.0/lash-x86_64-apple-darwin.tar.xz"
      sha256 "37b8e1eb48283b45a0de3a8b849ddcd4cb6a74a20866fec5a921952a17a34b44"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.3.0/lash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "28aec2561f82d9ba862f0130f209cdbe4714504b8392bbd9e1bab7d7a68ee0dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.3.0/lash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d8aa70a420a3708ef5139623da62e0debb1c6c769f0c7826e6001baa4efdf655"
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
