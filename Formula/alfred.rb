# typed: strict
# frozen_string_literal: true

class Alfred < Formula
  desc "Agent operations runtime for coding harnesses"
  homepage "https://alfred.alfredlabs.org"
  url "https://github.com/GOI17/alfred/releases/download/v1.1.0/alfred-1.1.0-runtime.tar.gz"
  sha256 "63fa13d309f5157a20d369c692a0e3b32e21dc8ce6cca500734fffb6d61c61cd"

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
