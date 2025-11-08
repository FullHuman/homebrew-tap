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

1. Download new release artifacts from GitHub
2. Update `version` in the formula
3. Update all `sha256` hashes from the release checksums
4. Commit and push to the tap repository
