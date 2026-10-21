# typed: strict
# frozen_string_literal: true

class Alfred < Formula
  desc "Agent operations runtime for coding harnesses"
  homepage "https://alfred.alfredlabs.org"
  url "https://github.com/GOI17/alfred/releases/download/v1.0.0/alfred-1.0.0-runtime.tar.gz"
  sha256 "56e398a40107d27b3b747e343db1e3b76f459238cf55cef2955560415a0c939e"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    libexec.install ".ai"
    chmod 0755, libexec/"install.sh"

    (bin/"alfred").write <<~SH
      #!/bin/sh
      ALFRED_DISTRIBUTION=homebrew exec "#{formula_opt_bin("node")}/node" "#{libexec}/packages/memory-server/scripts/alfred.mjs" "$@"
    SH
  end

  def caveats
    <<~EOS
      Alfred is installed preview-first. Run the guided setup with:
        alfred setup

      The formula does not write live harness configuration during installation.
    EOS
  end

  test do
    assert_equal "alfred #{version}", shell_output("#{bin}/alfred version").strip
    output = shell_output("#{bin}/alfred setup --edition=coding --name=brew-test --harness=none")
    assert_match "ALFRED SUITE INSTALL PREVIEW", output
    assert_match "Provider calls: 0", output
  end
end
