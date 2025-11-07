# Homebrew Formula Setup Instructions

This guide is for setting up the Homebrew formula in your tap repository.

## Prerequisites

- Access to `https://github.com/Decryptu/homebrew-tap`
- The `oak-sync` repository should be published on GitHub
- A tagged release should be created (e.g., v1.0.0)

## Steps to Set Up the Homebrew Formula

### 1. Create a GitHub Release

First, create a release of the `oak-sync` repository:

```bash
# In the oak-sync repository
git tag -a v1.0.0 -m "Initial release"
git push origin v1.0.0
```

Or create a release through the GitHub web interface.

### 2. Get the SHA256 Hash

After creating the release, download the tarball and calculate its SHA256:

```bash
curl -L https://github.com/Decryptu/oak-sync/archive/refs/tags/v1.0.0.tar.gz -o oak-sync-1.0.0.tar.gz
shasum -a 256 oak-sync-1.0.0.tar.gz
```

Copy the resulting SHA256 hash.

### 3. Add Formula to Your Tap

Clone your tap repository:

```bash
git clone https://github.com/Decryptu/homebrew-tap
cd homebrew-tap
```

Copy the formula file to the Formula directory:

```bash
# Copy from oak-sync/Formula/oak-sync.rb
cp /path/to/oak-sync/Formula/oak-sync.rb Formula/oak-sync.rb
```

Update the `sha256` field in `Formula/oak-sync.rb` with the hash from step 2.

### 4. Test the Formula Locally

Before pushing, test the formula:

```bash
# Audit the formula
brew audit --strict --online oak-sync

# Test installation locally
brew install --build-from-source Formula/oak-sync.rb

# Test that it works
oak-sync

# Uninstall after testing
brew uninstall oak-sync
```

### 5. Commit and Push

```bash
git add Formula/oak-sync.rb
git commit -m "Add oak-sync formula"
git push origin main
```

### 6. Installation Instructions for Users

After the formula is in your tap, users can install it with:

```bash
# First time: add the tap
brew tap decryptu/tap

# Install oak-sync
brew install oak-sync

# Or in one command
brew install decryptu/tap/oak-sync
```

## Formula File Explanation

```ruby
class OakSync < Formula
  desc "CLI tool for syncing Oak Research production branches with preprod"
  homepage "https://github.com/Decryptu/oak-sync"

  # URL to the release tarball
  url "https://github.com/Decryptu/oak-sync/archive/refs/tags/v1.0.0.tar.gz"

  # SHA256 hash of the tarball (calculate after creating release)
  sha256 "YOUR_SHA256_HASH_HERE"

  license "MIT"

  # Dependencies
  depends_on "gum"

  # Installation instructions
  def install
    # Install the oak-sync script to Homebrew's bin directory
    bin.install "oak-sync"
  end

  # Test that the installation worked
  test do
    assert_predicate bin/"oak-sync", :exist?
    assert_predicate bin/"oak-sync", :executable?
    system "which", "gum"
  end
end
```

## Updating the Formula

When you release a new version:

1. Create a new tag and release on GitHub
2. Update the `url` in the formula to point to the new version
3. Calculate and update the `sha256` hash
4. Update the version number if you're using explicit versioning
5. Commit and push the changes

## Reference: Existing Formula

You can reference the existing `zigdex.rb` formula in your tap for style consistency:

```bash
cd homebrew-tap
cat Formula/zigdex.rb
```

## Troubleshooting

### Formula Audit Fails

Run audit to see what's wrong:
```bash
brew audit --strict --online Formula/oak-sync.rb
```

Common issues:
- Incorrect SHA256 hash
- Missing or incorrect license
- URL not accessible
- Missing dependencies

### Installation Fails

Check the build output:
```bash
brew install --verbose --debug oak-sync
```

### Testing Issues

Make sure `gum` is installed:
```bash
brew install gum
```

## Best Practices

1. **Use semantic versioning** - Follow v1.0.0, v1.0.1, v1.1.0 format
2. **Test before publishing** - Always test the formula locally first
3. **Keep formula simple** - The script is already self-contained, so the formula just needs to install it
4. **Document changes** - Update the changelog in README.md for each release
5. **Verify checksums** - Always recalculate SHA256 for new releases

## Additional Resources

- [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
- [Homebrew Taps Documentation](https://docs.brew.sh/Taps)
- [Creating and Distributing Your Own Formulae](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap)
