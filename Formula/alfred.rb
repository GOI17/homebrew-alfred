# typed: strict
# frozen_string_literal: true

class Alfred < Formula
  desc "Agent operations runtime for coding harnesses"
  homepage "https://alfred.alfredlabs.org"
  url "https://github.com/GOI17/alfred.git",
      tag:      "v0.5.0",
      revision: "ee73a36af68c28ebb305d8290c8254f86cf091fa"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    libexec.install ".ai"
    chmod 0755, libexec/"install.sh"

    (bin/"alfred").write <<~SH
      #!/bin/sh
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/packages/memory-server/scripts/alfred.mjs" "$@"
    SH

    (bin/"alfred-install").write <<~SH
      #!/bin/sh
      if [ "$#" -eq 0 ]; then
        ALFRED_INSTALL_FORCE_TUI=1 exec "#{libexec}/install.sh" --path="#{libexec}" --no-clone
      fi
      exec "#{libexec}/install.sh" "$@" --path="#{libexec}" --no-clone
    SH
  end

  def caveats
    <<~EOS
      Alfred is installed preview-first. Run the guided setup with:
        alfred-install

      The formula does not write live harness configuration during installation.
    EOS
  end

  test do
    assert_equal "alfred #{version}", shell_output("#{bin}/alfred version").strip
    output = shell_output("#{bin}/alfred-install --edition=coding --name=brew-test --harness=none")
    assert_match "ALFRED SUITE INSTALL PREVIEW", output
    assert_match "Provider calls: 0", output
  end
end
