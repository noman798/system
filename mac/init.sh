
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


PREFIX=$(cd "$(dirname "$0")"; pwd)

brew install `cat $PREFIX//brew-backup/soft-brew.txt`
brew cask install `cat ~/brew-backup/soft-brew-cask.txt`
