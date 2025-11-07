# Prompt for AI Agent: Create Homebrew Formula for oak-sync

Copy and paste this entire prompt to your other AI agent:

---

**Task: Add oak-sync formula to my Homebrew tap repository**

## Context

I have a CLI tool called `oak-sync` that I need to add to my Homebrew tap at `https://github.com/Decryptu/homebrew-tap`. The tool is already released and I have all the necessary information.

## Repository Information

- **Tool Repository**: <https://github.com/Decryptu/oak-sync>
- **Tap Repository**: <https://github.com/Decryptu/homebrew-tap>
- **Release Version**: v1.0.0
- **Release URL**: <https://github.com/Decryptu/oak-sync/archive/refs/tags/v1.0.0.tar.gz>
- **SHA256 Hash**: [YOU NEED TO PROVIDE THIS - see instructions below]

## Before You Start

I need to provide you with the SHA256 hash. Run this command and give me the output:

```bash
curl -L https://github.com/Decryptu/oak-sync/archive/refs/tags/v1.0.0.tar.gz -o oak-sync-1.0.0.tar.gz
shasum -a 256 oak-sync-1.0.0.tar.gz
```

Then replace `[SHA256_HASH_HERE]` in the formula below with the actual hash.

## Instructions

1. **Clone the tap repository**:

   ```bash
   git clone https://github.com/Decryptu/homebrew-tap.git
   cd homebrew-tap
   ```

2. **Create the formula file** at `Formula/oak-sync.rb` with this content:

```ruby
class OakSync < Formula
  desc "CLI tool for syncing Oak Research production branches with preprod"
  homepage "https://github.com/Decryptu/oak-sync"
  url "https://github.com/Decryptu/oak-sync/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "[SHA256_HASH_HERE]"  # Replace with actual SHA256 from the command above
  license "MIT"

  depends_on "gum"

  def install
    bin.install "oak-sync"
  end

  test do
    # Test that the script exists and is executable
    assert_predicate bin/"oak-sync", :exist?
    assert_predicate bin/"oak-sync", :executable?
  end
end
```

3. **Replace the SHA256 hash** in the formula with the one you calculated

4. **Test the formula locally**:

   ```bash
   # Audit the formula
   brew audit --strict --online Formula/oak-sync.rb

   # Test installation (this will actually install it)
   brew install --build-from-source Formula/oak-sync.rb

   # Verify it works (it will show a TUI - just press ESC or Ctrl+C to exit)
   which oak-sync
   oak-sync --help || true  # May not have --help, that's ok

   # Uninstall after testing
   brew uninstall oak-sync
   ```

5. **If tests pass, commit and push**:

   ```bash
   git add Formula/oak-sync.rb
   git commit -m "Add oak-sync formula v1.0.0

   - CLI tool for syncing Oak Research repositories
   - Depends on gum for interactive TUI
   - Automates prod/preprod branch synchronization"

   git push origin main
   ```

## About oak-sync

oak-sync is a Terminal UI tool that:

- Allows interactive selection of multiple repositories using checkboxes
- Syncs production branches with preprod branches across Oak Research repos
- Performs: fetch, checkout prod, reset to preprod, force push
- Has built-in safety confirmations and error handling
- Shows progress for each operation

## Dependencies

- **gum**: Terminal UI toolkit (Homebrew package: `charmbracelet/tap/gum`)
  - The formula already specifies this as: `depends_on "gum"`

## Testing After Publishing

After you push to the tap, I'll test the end-user installation:

```bash
brew tap decryptu/tap
brew install oak-sync
oak-sync
```

## Expected File Structure in homebrew-tap

After your changes, the tap should look like:

```
homebrew-tap/
├── Formula/
│   ├── oak-sync.rb      # New file you're creating
│   └── zigdex.rb         # Existing formula (for reference)
└── README.md
```

## Troubleshooting

**If audit fails:**

- Check SHA256 matches the tarball exactly
- Ensure URL is accessible
- Verify Ruby syntax is correct

**If installation fails:**

- Check that the `oak-sync` file exists in the root of the tarball
- Verify it has executable permissions (it should in the tarball)
- Make sure gum is available: `brew install gum`

**If the formula works but oak-sync doesn't run:**

- The issue is likely with the tool itself, not the formula
- Check that gum is installed: `which gum`

## Reference

You can look at the existing `zigdex.rb` formula in the same repo for style reference:

```bash
cat Formula/zigdex.rb
```

## Summary of Your Tasks

1. ✅ Calculate SHA256 hash of the release tarball
2. ✅ Clone homebrew-tap repository
3. ✅ Create Formula/oak-sync.rb with the correct SHA256
4. ✅ Test the formula locally with brew audit and brew install
5. ✅ Commit and push to the tap repository
6. ✅ Notify me when done so I can test end-user installation

---

**End of prompt for AI agent**

## What I Need From You

After creating the release (Step 1 above), provide the other AI agent with:

1. This entire prompt
2. The SHA256 hash you calculated (to replace `[SHA256_HASH_HERE]`)
3. Confirmation that the release v1.0.0 is published and accessible

The AI agent will handle the rest!
