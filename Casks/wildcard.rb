cask "wildcard" do
  version "1.0.0"
  sha256 "54d611a3c033727c1927ddbca6349c324806cd0733d985ba0a1faea336764f80"

  url "https://github.com/maksim-shabunov/wildcard/releases/download/v#{version}/Wildcard-#{version}-macos-universal.zip"
  name "Wildcard"
  desc "Set default applications by category, with every change reviewed first"
  homepage "https://github.com/maksim-shabunov/wildcard"

  depends_on macos: ">= :sonoma"

  app "Wildcard.app"

  # Wildcard is signed ad-hoc: it has no paid Apple Developer account and so
  # cannot be notarised. Homebrew quarantines what it downloads, and a
  # quarantined ad-hoc bundle is refused outright rather than merely warned
  # about, so the flag is cleared on the way in. The checksum above is what
  # actually vouches for this download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Wildcard.app"],
                   sudo: false
  end

  uninstall quit: "com.wildcard.Wildcard"

  zap trash: [
    "~/Library/Application Support/Wildcard",
  ]
end
