### VARIABLES

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GO111MODULE=on
export CGO_ENABLED=0

# Node
export PATH=$PATH:$HOME/.npm-global/bin

export NOTES="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# List all java versions using `/usr/libexec/java_home -V`
# Java 11
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
