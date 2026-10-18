# Alfred Homebrew tap

> This public tap distributes Alfred's [latest stable release](https://github.com/GOI17/alfred/releases/latest).
> Homebrew installs the versioned runtime using the SHA-256 pinned in the formula.

[Alfred](https://github.com/GOI17/alfred) handles the operational burden so humans
focus on decisions. This public dedicated tap distributes its versioned runtime through Homebrew.

## Install

```sh
brew install GOI17/alfred/alfred
alfred version
alfred setup
```

Use the qualified formula name to distinguish Alfred from the unrelated macOS
application cask. The public tap and release downloads require no GitHub login.
Homebrew provides Node and downloads the exact release runtime with its pinned
SHA-256. Production dependencies are bundled; users do not need a source checkout
or an npm install.

Install the runtime once, then configure each project deliberately. Interactive
`alfred setup` uses the bundled Go TUI built with Bubble Tea and Lip Gloss.
Setup shows a preview before changes; confirm with `y`, or return with `n` or Esc.
It does not clone `main`, fetch a different installer, or download Go at runtime.
Installing this formula does not activate a live harness or authorize global
configuration changes.

For managed text-loading requests, initialize each project separately:

```sh
alfred runtime init --instructions /absolute/path/to/shared/instructions.json
alfred runtime status
```

The required shared instruction manifest governs Alfred's managed requests.
Project state and content-bound consent stay in that project's `.alfred/runtime/`.
Memory `alfred init` remains a separate operation. See the
[runtime guide](https://github.com/GOI17/alfred/blob/main/docs/runtime-authority.md)
for the current capability and host-integration limits.

## Verify releases

The [latest stable release](https://github.com/GOI17/alfred/releases/latest) contains:

- `alfred-<version>-runtime.tar.gz`
- `runtime-manifest.json`
- `SHA256SUMS`
- `alfred.rb`

Download all four assets from the same approved version, then verify them with
`shasum -a 256 -c SHA256SUMS` in the download directory. The manifest inventories
the archive and records source/build provenance. The package includes readable
runtime code and third-party licenses; it is not an opaque native binary.

## Maintenance

The source repository's Release Please pipeline creates an approved stable
release, validates and uploads its runtime assets, verifies anonymous downloads,
and only then updates this tap's `Formula/alfred.rb` automatically with its
existing repository-scoped deploy key. Identical retries are safe; differing
existing assets are rejected without replacement. Manual formula copying is a
recovery procedure, not the normal release process.

See the [packaging guide](https://github.com/GOI17/alfred/blob/main/packaging/homebrew/README.md)
for verification and recovery. Never overwrite existing release assets with
different bytes. Do not backfill older releases with assets built from newer source.
