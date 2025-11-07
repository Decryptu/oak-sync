# Release Instructions for oak-sync

Follow these steps to prepare oak-sync for Homebrew distribution.

## Step 1: Create a GitHub Release

### Option A: Using GitHub Web Interface (Recommended)

1. Go to: https://github.com/Decryptu/oak-sync/releases/new

2. Fill in the release form:
   - **Tag version**: `v1.0.0` (create new tag)
   - **Release title**: `v1.0.0 - Initial Release`
   - **Description**:
     ```markdown
     ## Oak Sync v1.0.0

     Initial release of oak-sync CLI tool for syncing Oak Research repositories.

     ### Features
     - Interactive TUI using gum for repository selection
     - Multi-repository sync support (7 Oak Research repos)
     - Safety confirmations before force-push operations
     - Progress indicators for each operation
     - Comprehensive error handling and validation
     - Detailed success/error reporting with summary

     ### Installation

     ```bash
     # Using Homebrew (coming soon)
     brew tap decryptu/tap
     brew install oak-sync

     # Manual installation
     curl -L https://github.com/Decryptu/oak-sync/archive/refs/tags/v1.0.0.tar.gz | tar xz
     cd oak-sync-1.0.0
     chmod +x oak-sync
     sudo mv oak-sync /usr/local/bin/
     ```

     ### Requirements
     - macOS
     - gum (`brew install gum`)
     - git
     ```

3. Click **"Publish release"**

### Option B: Using Git Command Line

```bash
cd /path/to/oak-sync

# Create and push the tag
git tag -a v1.0.0 -m "Initial release - Oak Sync CLI tool"
git push origin v1.0.0

# Then create the release on GitHub web interface using the tag
```

## Step 2: Calculate SHA256 Hash

After creating the release, download the tarball and calculate its SHA256:

```bash
# Download the release tarball
curl -L https://github.com/Decryptu/oak-sync/archive/refs/tags/v1.0.0.tar.gz -o oak-sync-1.0.0.tar.gz

# Calculate SHA256
shasum -a 256 oak-sync-1.0.0.tar.gz

# Or on Linux:
# sha256sum oak-sync-1.0.0.tar.gz
```

**Copy the resulting hash** - you'll need it for the Homebrew formula.

Example output:
```
abc123def456... oak-sync-1.0.0.tar.gz
```

## Step 3: Update the Homebrew Formula

Now you'll work with another AI agent to:
1. Clone your `homebrew-tap` repository
2. Create/update `Formula/oak-sync.rb` with the SHA256 hash
3. Test the formula
4. Push to your tap repository

See `PROMPT_FOR_AI_AGENT.md` for the complete prompt to use.

## Step 4: Test Installation (After tap is updated)

```bash
# Test the installation
brew tap decryptu/tap
brew install oak-sync

# Verify it works
oak-sync

# Clean up test
brew uninstall oak-sync
```

## Future Releases

For subsequent releases (v1.0.1, v1.1.0, etc.):

1. Make your changes and commit them
2. Update version in any relevant files
3. Create a new tag: `git tag -a v1.0.1 -m "Bug fixes"`
4. Push the tag: `git push origin v1.0.1`
5. Create GitHub release for the new tag
6. Calculate new SHA256
7. Update the Homebrew formula with new URL and SHA256

## Notes

- Always use semantic versioning: MAJOR.MINOR.PATCH
- The Homebrew formula URL and SHA256 must match the release
- Test the formula locally before pushing to the tap
- Document changes in release notes
