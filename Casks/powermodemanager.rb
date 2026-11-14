cask "powermodemanager" do
  version "1.0.0"
  sha256 "8050ad479d0ba06180853c76f72208568191d00bd781a300364a39f3c159f35e"

  url "https://github.com/powermodeapp/PowerModeManager-Releases/releases/download/v#{version}/PowerModeManager.dmg"
  name "PowerModeManager"
  desc "Switch between server and everyday power modes"
  homepage "https://powermodeapp.github.io/"

  livecheck do
    url "https://github.com/powermodeapp/PowerModeManager-Releases/releases/latest"
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "PowerModeManager.app"
end
