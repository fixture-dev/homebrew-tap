class Lash < Formula
  desc "Minimalist, Markdown-native task tracker for devs and agents"
  homepage "https://github.com/fixture-dev/lash"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.2.0/lash-aarch64-apple-darwin.tar.xz"
      sha256 "f77748db31d210f9be22b96faca0e6c673dac2752a1971f18aef9afecaa84700"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.2.0/lash-x86_64-apple-darwin.tar.xz"
      sha256 "832a72d4a15d5f75559a393bfedbbfff7a5e7a39a0628bb87cc5256e99fb91cb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/fixture-dev/lash/releases/download/v0.2.0/lash-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9dc7287e5c4c57730e315065d2e4948f34f16fd2f246365f4c85eeb12187fa3e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/fixture-dev/lash/releases/download/v0.2.0/lash-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7db61bd2ba6abf35e8b7d2b6f66c495a25eb77458e8b5d49911c96ea486a1cca"
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
