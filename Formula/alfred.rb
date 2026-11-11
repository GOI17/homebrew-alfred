# typed: strict
# frozen_string_literal: true

class Alfred < Formula
  desc "Workspace, memory and agent harness runtime"
  homepage "https://alfred.alfredlabs.org"
  url "https://github.com/GOI17/alfred/releases/download/v1.6.0/alfred-1.6.0-runtime.tar.gz"
  sha256 "6e109446d573b50b8595e35b7337c5c44002d4b38366fb916e0f8f2960baee99"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    libexec.install ".ai"
    chmod 0755, libexec/"install.sh"

    (bin/"alfred").write <<~SH
      #!/bin/sh
      ALFRED_DISTRIBUTION=homebrew exec "#{formula_opt_bin("node")}/node" "#{libexec}/packages/cli/scripts/alfred.mjs" "$@"
    SH
    {
      "alfred-workspace"     => "workspace/scripts/cli.mjs",
      "alfred-memory"        => "memory-server/scripts/memory.mjs",
      "alfred-agent-harness" => "agent-harness/scripts/cli.mjs",
    }.each do |command, entrypoint|
      (bin/command).write <<~SH
        #!/bin/sh
        ALFRED_DISTRIBUTION=homebrew exec "#{formula_opt_bin("node")}/node" "#{libexec}/packages/#{entrypoint}" "$@"
      SH
    end
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
    assert_match "Workspace", shell_output("#{bin}/alfred-workspace --help")
    system formula_opt_bin("node")/"node", libexec/"scripts/verify-workspace-native.mjs", libexec/"node_modules"
  end
end
