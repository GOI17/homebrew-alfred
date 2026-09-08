# Alfred Homebrew distribution

This tap is being prepared for installation by third parties without access to
the private Alfred development repository. Public activation is pending approval
of the runtime artifact and this repository's visibility. The commands below
become available only after that activation.

## Install after public activation

With Homebrew installed:

```sh
brew tap GOI17/alfred
brew install GOI17/alfred/alfred
alfred version
alfred setup
```

No GitHub login or collaborator access is required for the public distribution.
Use the fully qualified formula name; unqualified `brew install alfred` can
select the unrelated macOS application cask.

The formula downloads a versioned runtime archive from this repository's public
GitHub Release and verifies its SHA-256. It does not clone or download the private
source repository. Homebrew installs Node as a declared dependency. Setup is
guided and preview-first; applying harness configuration remains your decision.

## What the package contains

The runtime archive distributes **readable JavaScript and shell code**, necessary
HTML/UI, SQL/schema files, runtime agent/skill/policy instructions, and production
dependencies with their license notices. It is not an opaque native binary and
packaging does not hide the distributed code. The private development repository
and its Git history remain separate.

Each release includes an exact content manifest and archive checksum. The
packaging allowlist excludes development history, workflow configuration, tests,
internal execution documents, operation traces, local configuration and secrets.
The Node guided installer is included; optional native OpenTUI binaries and
Transformers model downloads are not part of this runtime package.

## Verify a published package

The release asset and its manifest must be downloadable without authentication.
If the tap is reachable but the runtime URL returns 404, this is a distribution
publication problem for the maintainer to resolve. Do not request access to the
private development repository as an installation workaround.

```sh
brew update
brew info GOI17/alfred/alfred
brew upgrade GOI17/alfred/alfred
```

To remove the package:

```sh
brew uninstall GOI17/alfred/alfred
```

## Release controls

Private preparation builds a curated artifact for review. Public publication is
a separate manual operation tied to the approved archive checksum and target.
The publisher verifies public anonymous asset download before activating the
formula, and refuses to replace an existing version with different bytes.

Repository visibility changes, first public publication and release credentials
are human-controlled operations; merging a preparation PR is not authorization
to expose private source or publish a runtime archive.
