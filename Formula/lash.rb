class Lash < Formula
  desc "Minimalist, Markdown-native task tracker for devs and agents"
  homepage "https://github.com/fixture-dev/lash"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.4.0/lash-aarch64-apple-darwin.tar.xz"
      sha256 "f1a36f865e30c523f03f41bf72386e2cb8a9d167ddc8d0a12918ce241311b6e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.4.0/lash-x86_64-apple-darwin.tar.xz"
      sha256 "2cbc8bf3db1fa0473afff34db481005c2b77647a2517858983067df9516be3e2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.4.0/lash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ccd6ef5f0e1b9e23171fa68bb55971ea1feb3be5450ff13a390eb5083d819335"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.4.0/lash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7e067a875cfd687eefd6712dc7157d3778c1fdf6fc33746f0014b2f5f1abe695"
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
