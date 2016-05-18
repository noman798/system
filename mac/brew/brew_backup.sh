mkdir -p brew-backup/
brew leaves > brew-backup/soft-brew.txt
brew cask list -1 > brew-backup/soft-brew-cask.txt
