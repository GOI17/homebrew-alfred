# Alfred Homebrew tap

This private repository publishes the versioned Alfred CLI. The current tap is
`GOI17/alfred`, which Homebrew maps to `GOI17/homebrew-alfred`.

## Install on another computer

You need Git, GitHub CLI (`gh`), and Homebrew on that computer, plus a GitHub
account with read access to **both** `GOI17/homebrew-alfred` (this tap) and
`GOI17/alfred` (the private Git source used by the formula).

Authenticate using HTTPS and configure Git's GitHub credential helper on that
computer:

```sh
gh auth login --hostname github.com --git-protocol https
gh auth setup-git --hostname github.com
```

Verify repository, formula, and Git access before installing:

```sh
gh api repos/GOI17/homebrew-alfred --jq .full_name
gh api repos/GOI17/alfred --jq .full_name
gh api repos/GOI17/homebrew-alfred/contents/Formula/alfred.rb --jq .path
git ls-remote https://github.com/GOI17/homebrew-alfred.git HEAD
git ls-remote https://github.com/GOI17/alfred.git HEAD
```

After all checks succeed, register the tap explicitly so tap access and source
installation are separate steps:

```sh
brew tap GOI17/alfred
brew install GOI17/alfred/alfred
alfred version
alfred setup
```

Always use the fully qualified formula name. Plain `brew install alfred` can
select the unrelated Alfred macOS application cask. `alfred setup` is guided
and preview-first; the formula does not write live harness configuration.

## Troubleshooting

- A private repository may return `404` or `Repository not found` when the
  account lacks access. Check the signed-in account and access to both repos;
  a 404 alone does not establish that publication failed.
- If API reads work but `git ls-remote` fails, check HTTPS Git authentication.
  `gh auth setup-git --hostname github.com` configures Git, while API success
  alone does not prove Git is using the same credentials.
- If both repositories are accessible but `Formula/alfred.rb` is absent or
  stale, compare it with the stable Alfred release/tag and inspect the publisher
  job in Alfred's Release Please workflow. Do not create a new release merely
  to diagnose an access error.
- The former name `GOI17/homebrew-tap` still redirected for authenticated reads
  on 2026-09-07. New installs should use the current name. Changing capitalization
  does not repair authentication; existing old-name taps do not need to be
  removed to diagnose access.

The full [Alfred installation guide](https://alfred.alfredlabs.org/docs/install.html#homebrew-troubleshooting)
contains release/publisher checks. Never paste access tokens into issue reports.

## Upgrade or uninstall

For installations using the current tap name:

```sh
brew update
brew upgrade GOI17/alfred/alfred
brew uninstall GOI17/alfred/alfred
```

## Maintainer context

The formula pins the private source by tag and full commit revision. Alfred's
release workflow publishes it using the existing repository-scoped deploy key.
Repository visibility and release publication remain separate maintainer decisions.

Tracked in [Alfred issue #204](https://github.com/GOI17/alfred/issues/204) and its
[installation-access specification](https://github.com/GOI17/alfred/blob/issue-204-homebrew-tap-access/.ai/execution/homebrew-tap-access.md).
See also [Homebrew tap naming](https://docs.brew.sh/Taps) and the
[GitHub CLI credential helper](https://cli.github.com/manual/gh_auth_setup-git).
