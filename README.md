# Homebrew Formula

## Installing from the Tap

Once the tap is set up, users can install with:

```bash
# Add the tap (only needed once)
brew tap FullHuman/tap

# Install orphos
brew install orphos

# Or install directly without tapping
brew install FullHuman/tap/orphos
```

## Updating the Formula

When releasing a new version:

1. Update the version in every `url` in the formula (Homebrew reads the
   version of the formula from them)
2. Update the `sha256` of each release archive from the `.sha256` files of the
   GitHub release
3. Update the `sha256` of the source archive
   (`https://github.com/FullHuman/orphos/archive/refs/tags/vX.Y.Z.tar.gz`),
   which Intel Macs build from: the releases have no binary for them
4. Check the formula: `brew style FullHuman/tap`, then `brew upgrade orphos`
   and `brew test orphos` from a checkout of the change
5. Commit and push to the tap repository
