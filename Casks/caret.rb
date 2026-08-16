cask "caret" do
  version "1.0.0"
  sha256 "4226708ef157840508c5ab422867f0367cc0c1fb61a3659e63ca831afe288c9d"

  url "https://github.com/maksim-shabunov/caret/releases/download/v#{version}/Caret-#{version}.zip"
  name "Caret"
  desc "Fixes text typed on the wrong keyboard layout"
  homepage "https://github.com/maksim-shabunov/caret"

  depends_on macos: :sequoia

  app "Caret.app"

  # Caret is signed, but ad hoc: signing in the way Gatekeeper accepts without
  # complaint needs a paid Apple Developer account, which the project does not
  # have. Homebrew flags every download it did not fetch from a notarised
  # source, so the flag is cleared here — exactly what --no-quarantine does,
  # made the default so that installing does not need a flag nobody remembers.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Caret.app"],
                   sudo: false
  end

  uninstall quit: "com.maksim.caret"

  zap trash: [
    "~/Library/Application Support/Caret",
    "~/Library/Preferences/com.maksim.caret.plist",
  ]
end
