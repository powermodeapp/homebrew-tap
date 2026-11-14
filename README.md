# PowerModeManager Homebrew Tap

Install PowerModeManager on Apple Silicon Macs running macOS 15 or later:

```sh
brew install --cask powermodeapp/tap/powermodemanager
```

Or add the tap first, then install by its short name:

```sh
brew tap powermodeapp/tap
brew install --cask powermodemanager
```

Homebrew installs the signed and notarized app from the public [PowerModeManager release](https://github.com/powermodeapp/PowerModeManager-Releases/releases). To remove it, run `brew uninstall --cask powermodemanager`. App settings, logs, and backups remain in your home folder.

A scheduled GitHub Actions workflow checks for new stable releases and opens a pull request with the updated version and SHA-256 checksum. Review and merge that pull request to publish each Cask update.
