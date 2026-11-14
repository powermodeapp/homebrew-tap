# PowerModeManager Homebrew Tap

Install PowerModeManager on Apple Silicon Macs running macOS 15 or later. Homebrew 7 requires explicit trust for non-official Casks; trust only this Cask, then install it:

```sh
brew tap powermodeapp/tap
brew trust --cask powermodeapp/tap/powermodemanager
brew install --cask powermodemanager
```

Homebrew installs the signed and notarized app from the public [PowerModeManager release](https://github.com/powermodeapp/PowerModeManager-Releases/releases). To remove it, run `brew uninstall --cask powermodemanager`. App settings, logs, and backups remain in your home folder.

A scheduled GitHub Actions workflow checks for new stable releases and opens a pull request with the updated version and SHA-256 checksum. Review and merge that pull request to publish each Cask update.
