class Lash < Formula
  desc "Minimalist, Markdown-native task tracker for devs and agents"
  homepage "https://github.com/fixture-dev/lash"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.5.0/lash-aarch64-apple-darwin.tar.xz"
      sha256 "df55c1843466fe7a23faabe85873c124b366b901310b7da1199925f55132ca75"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.5.0/lash-x86_64-apple-darwin.tar.xz"
      sha256 "ae90b6c9dd90dd7d786c21b4c8e011d7fb838c03372994a5337fbbdf18c15fd2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.5.0/lash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "858ca3389cb6d16f475af91bc4f89c1596cdc7cb6dd807c7c3c4b1bf8b23045b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.5.0/lash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "30c7202830e93565297d1974c81f55c0a2e6491ecc0918ee0db5d19ff97f21f5"
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
