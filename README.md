# Oak Sync

A macOS CLI tool for syncing production branches with preprod across multiple Oak Research repositories.

## Overview

`oak-sync` is a Terminal User Interface (TUI) tool that simplifies the process of synchronizing your production branches with preprod across multiple git repositories. It uses `gum` for an interactive, user-friendly experience.

## What It Does

After merging `preprod → prod` via pull request, you often need to sync both branches by force-pushing preprod to prod. This tool automates that process across all your Oak Research repositories.

For each selected repository, `oak-sync`:
1. Fetches the latest changes from origin
2. Checks out the `prod` branch
3. Resets `prod` to match `origin/preprod`
4. Force-pushes to `origin/prod`

## Installation

### Using Homebrew (Recommended)

```bash
# Add the tap
brew tap decryptu/tap

# Install oak-sync
brew install oak-sync
```

### Manual Installation

1. Clone this repository:
```bash
git clone https://github.com/Decryptu/oak-sync.git
cd oak-sync
```

2. Install dependencies:
```bash
brew install gum
```

3. Make the script executable:
```bash
chmod +x oak-sync
```

4. Move it to your PATH:
```bash
sudo cp oak-sync /usr/local/bin/
```

## Usage

Simply run:

```bash
oak-sync
```

The tool will:
1. Display a welcome screen
2. Show a checkbox list of all Oak Research repositories
3. Allow you to select which repos to sync (use Space to select, Enter to confirm)
4. Display a confirmation prompt listing all selected repos
5. Ask for final confirmation before proceeding
6. Execute the sync process with visual progress indicators
7. Show a summary of successful and failed operations

### Interactive Demo

```
┌────────────────────────────────────────────────────────┐
│                                                        │
│                                                        │
│         Oak Research Repository Sync Tool             │
│                                                        │
│     Sync prod branch with preprod across multiple     │
│                       repos                            │
│                                                        │
│                                                        │
└────────────────────────────────────────────────────────┘

⚠️  WARNING: This tool uses force-push operations!

Select repositories to sync (use space to select, enter to confirm):

> [ ] oak-research-api
  [ ] oak-research-back
  [ ] oak-research-bots
  [ ] oak-research-front
  [ ] oak-research-maintenance
  [ ] oak-research-scripts
  [ ] oak-research-webhook
```

## Repository Configuration

The tool expects repositories to be located at:
```
/Users/gurvan/documents/github/oak-research-{name}
```

Where `{name}` is one of:
- `api`
- `back`
- `bots`
- `front`
- `maintenance`
- `scripts`
- `webhook`

## Safety Features

### ⚠️ Important Safety Warnings

**This tool performs FORCE PUSH operations!**

Before using `oak-sync`:

1. **Ensure all local changes are committed** - Force pushing will overwrite the remote prod branch
2. **Verify preprod is ready** - The tool will sync prod to match preprod exactly
3. **Communicate with your team** - Force pushing affects all collaborators
4. **Have a backup plan** - Know how to recover if something goes wrong
5. **Review the changes** - The tool shows you what will happen before executing

### Built-in Safety Checks

The tool includes several safety features:

- **Confirmation prompts** - You must explicitly confirm before any changes are made
- **Directory validation** - Checks that repositories exist before proceeding
- **Git repository validation** - Ensures directories are valid git repos
- **Branch existence checks** - Verifies both preprod and prod branches exist
- **Fetch before sync** - Always gets the latest from remote before syncing
- **Detailed error messages** - Clear feedback if something goes wrong
- **Summary report** - Shows exactly what succeeded and what failed

### What Gets Modified

When you sync a repository:
- **Local `prod` branch** - Reset to match `origin/preprod`
- **Remote `prod` branch** - Force-pushed to match `origin/preprod`
- **No other branches are affected**

### Recovery

If you need to undo a sync:

1. Find the previous commit hash:
```bash
git reflog
```

2. Reset to that commit:
```bash
git reset --hard <commit-hash>
```

3. Force push to restore:
```bash
git push --force
```

## Requirements

- macOS (tested on macOS 10.15+)
- zsh or bash
- [gum](https://github.com/charmbracelet/gum) - Terminal UI toolkit
- git
- Access to Oak Research repositories

## Troubleshooting

### "gum is not installed"

Install gum using Homebrew:
```bash
brew install gum
```

### "Directory not found"

Ensure your repositories are located at the expected path:
```bash
ls /Users/gurvan/documents/github/oak-research-*
```

### "Not a git repository"

The directory exists but isn't a git repository. Re-clone it:
```bash
cd /Users/gurvan/documents/github
git clone <repository-url>
```

### "Branch does not exist"

Either the `prod` or `preprod` branch doesn't exist on origin. Verify:
```bash
cd /path/to/repo
git fetch origin
git branch -r
```

### "Failed to fetch/push"

Check your network connection and git credentials:
```bash
git fetch origin
git remote -v
```

## Development

### Testing

You can test the script without making changes by:
1. Creating test repositories in a different location
2. Modifying the `BASE_PATH` variable in the script
3. Running the script against test repos

### Modifying Repository List

To add or remove repositories, edit the `REPO_NAMES` array in the script:

```bash
REPO_NAMES=("api" "back" "bots" "front" "maintenance" "scripts" "webhook")
```

### Changing Branch Names

To use different branch names, modify these variables:

```bash
PREPROD_BRANCH="preprod"
PROD_BRANCH="prod"
```

## Contributing

This is a personal tool for Oak Research workflow. If you want to adapt it for your own use:

1. Fork the repository
2. Modify the configuration variables
3. Test thoroughly before using in production

## License

MIT License - Feel free to use and modify for your own needs.

## Support

For issues or questions:
- Open an issue on GitHub
- Contact the Oak Research development team

## Changelog

### v1.0.0
- Initial release
- Interactive TUI with gum
- Multi-repository selection
- Safety confirmations
- Progress indicators
- Error handling and validation
- Comprehensive summary reporting
