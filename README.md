# Alfred Homebrew distribution

Public activation is pending explicit approval. The reviewed formula now points to a curated runtime release asset; that asset is not public yet. The source repository GOI17/alfred and its Git history remain private.

After public activation, install without a GitHub account, token or source access:

```sh
brew tap GOI17/alfred
brew install GOI17/alfred/alfred
alfred version
alfred setup
```

Use the qualified formula name to avoid the unrelated macOS application cask. Homebrew supplies Node; setup is guided and preview-first. The runtime uses its packaged Node TUI without private source or OpenTUI downloads.

The reviewed v0.7.2 candidate contains 1,895 files (including its complete inventory), occupying 1,999,956 compressed bytes. It includes readable JavaScript, shell, HTML, SQL, runtime agent/skill/policy instructions and 109 production dependencies with license notices. It is not an opaque native binary. Git history, workflows, tests, internal execution records, local profiles and credentials are excluded.

Runtime SHA256: `49bcb601b25190afc7a9b56dd2a78e3ceabf6004fdf7b718b6072681b8f2aed7`.

Proposed asset: `https://github.com/GOI17/homebrew-alfred/releases/download/v0.7.2/alfred-0.7.2-runtime.tar.gz`.

The archive was built twice with identical bytes from exact private source/builder revision 303ad82c4ba9fdc4641feb0f30e2aef3cd3313c7. This distribution includes packaging and fresh-machine fixes; it is not a repack of the old private v0.7.2 tag. Local verification covers anonymous HTTP retrieval, relocated CLI, guided setup previews, live HTTP server, SQLite and MCP CRUD/search. Real anonymous GitHub/Homebrew installation remains pending activation.

PR validation checks the formula syntax and public release URL/hash contract without downloads. The manual public-install workflow may be invoked only after public activation has been specifically authorized. Maintainers retain the exact approved artifact/formula; rebuilding under a later commit requires another checksum review.
