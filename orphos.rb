# typed: strict
# frozen_string_literal: true

class Orphos < Formula
  desc "Gene prediction tool for finding protein-coding genes in microbial genomes"
  homepage "https://github.com/FullHuman/orphos"
  license "GPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/FullHuman/orphos/releases/download/v0.5.0/orphos-cli-aarch64-darwin.tar.gz"
      sha256 "e38d1384549f91ddaa4006f3e372f28d31bd4f3d227a486b80c00745632299db"
    end

    # The releases have no binary for Intel Macs, so Orphos is built from
    # the sources of the release there.
    on_intel do
      url "https://github.com/FullHuman/orphos/archive/refs/tags/v0.5.0.tar.gz"
      sha256 "04c89148446a3ea174b7538210b23d62ecc617a4d26f0d320159627152a4ae50"

      depends_on "rust" => :build
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/FullHuman/orphos/releases/download/v0.5.0/orphos-cli-aarch64-linux.tar.gz"
      sha256 "d2498111617c07bba1813b218a42143ee94f327358ecbfa48e003cdf0f899c23"
    end

    on_intel do
      url "https://github.com/FullHuman/orphos/releases/download/v0.5.0/orphos-cli-x86_64-linux.tar.gz"
      sha256 "94683514c9dd328a4704673d2a0c3b99efd54863dcdb0f197a8289caf2b1c2e3"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.intel?
      system "cargo", "install", *std_cargo_args(path: "orphos-cli")
    else
      # A release archive holds one file, the binary, named after its platform.
      bin.install Dir["orphos-cli-*"].first => "orphos"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/orphos --version")

    gene = "ATGAAACGCATTAGCACCACCATTACCACCACCATCACCATTACCACAGGTAACGGTGCGGGCTGA"
    (testpath/"contigs.fasta").write <<~FASTA
      >first
      #{gene * 6}
      >second
      #{gene * 8}
    FASTA
    output = shell_output("#{bin}/orphos -q -p meta -f gff -i contigs.fasta")
    assert_match "# Sequence Data: seqnum=2;", output
    assert_match "\tCDS\t", output
  end
end
