# scalinity/homebrew-tap

Personal Homebrew tap for tools by [@scalinity](https://github.com/scalinity).

## Install

```bash
brew install scalinity/tap/preback
```

`brew` auto-taps when you give it the qualified `<user>/<tap>/<formula>` form, so the single command above is enough — no separate `brew tap` step required.

## Available formulae

| Formula | Description | Source |
| --- | --- | --- |
| `preback` | Pre-Time-Machine cleanup CLI for macOS. | [scalinity/PreBack](https://github.com/scalinity/PreBack) |

## Updating

```bash
brew update
brew upgrade preback
```

## Uninstall

```bash
brew uninstall preback
brew untap scalinity/tap   # optional — removes the tap entirely
```

## For maintainers — release flow

To ship a new `preback` version through this tap:

```bash
# 1. In the preback repo, bump the version + tag a release.
#    (Edit pyproject.toml, commit, then:)
git tag v0.1.1
git push origin main --tags

# 2. Compute the tarball SHA from the new tag.
curl -sL https://github.com/scalinity/PreBack/archive/refs/tags/v0.1.1.tar.gz \
  | shasum -a 256

# 3. In THIS repo, edit Formula/preback.rb:
#      - update `url` to the new tag
#      - paste the SHA into `sha256`
#    Commit + push.

# 4. Verify locally before announcing:
brew untap scalinity/tap 2>/dev/null
brew install scalinity/tap/preback
preback --version
brew audit --strict --formula scalinity/tap/preback   # warnings about
                                                       # license / homepage
                                                       # are fine for a
                                                       # personal tap.

# 5. Tell users: brew update && brew upgrade preback
```

`head` mode is also wired up in the formula, so during iteration anyone
can install latest `main` without waiting for a tagged release:

```bash
brew install --HEAD scalinity/tap/preback
```
