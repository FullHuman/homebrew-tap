# Homebrew Formula for Orphos CLI
# This formula should be placed in a homebrew-tap repository
# Instructions for creating a tap: https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap

class Orphos < Formula
  desc "Gene prediction tool for finding protein-coding genes in microbial genomes"
  homepage "https://github.com/FullHuman/orphos"
  version "0.1.0"  # Update this with each release
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/FullHuman/orphos/releases/download/v#{version}/orphos-cli-aarch64-darwin.tar.gz"
      sha256 "b930fee82a5d13bbc7f1356ad752c4714ebf0def87e43d45e40972e4645a25b0"
    else
      url "https://github.com/FullHuman/orphos/releases/download/v#{version}/orphos-cli-x86_64-darwin.tar.gz"
      sha256 "21da467bf29869c2e516c6733aedbe28495f203eae908af6826070c340cedcd3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/FullHuman/orphos/releases/download/v#{version}/orphos-cli-aarch64-linux.tar.gz"
      sha256 "5a75a00f9a54ba3b09042484436c2eeef3d6014cec92d2488522deb460198467"
    else
      url "https://github.com/FullHuman/orphos/releases/download/v#{version}/orphos-cli-x86_64-linux.tar.gz"
      sha256 "eaa15b0fa4fe7063fe6aa16d8cf8b012b5417e1be7ecdbf6f1ce15377abddab6"
    end
  end

  def install
    bin.install "orphos-cli-aarch64-darwin" => "orphos" if Hardware::CPU.arm? && OS.mac?
    bin.install "orphos-cli-x86_64-darwin" => "orphos" if Hardware::CPU.intel? && OS.mac?
    bin.install "orphos-cli-aarch64-linux" => "orphos" if Hardware::CPU.arm? && OS.linux?
    bin.install "orphos-cli-x86_64-linux" => "orphos" if Hardware::CPU.intel? && OS.linux?
  end

  test do
    assert_match "orphos", shell_output("#{bin}/orphos --version")
  end
end
