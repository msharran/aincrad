set -gx PATH $PATH $HOME/bin
set -gx PATH $PATH $HOME/sbin
set -gx PATH $PATH /opt/homebrew/bin
set -gx PATH $PATH $HOME/.local/bin

# Go
set -gx PATH $PATH $HOME/.local/go/bin
set -gx GOPATH $HOME/go
set -gx PATH $PATH $GOROOT/bin
set -gx PATH $PATH $GOPATH/bin
set -gx GO111MODULE on
set -gx CGO_ENABLED 0

# Node
set -gx PATH $PATH $HOME/.npm-global/bin

# Ruby
set -gx PATH $PATH $HOME/.rvm/bin

# XDG_CONFIG_HOME
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state


# Brew luarocks
# set -gx DYLD_LIBRARY_PATH "$(brew --prefix)/lib" $DYLD_LIBRARY_PATH

# Less options, set colors and line numbers
set -gx LESS '--chop-long-lines --RAW-CONTROL-CHARS'

if type -q zoxide
    zoxide init fish | source
end

if type -q direnv
    direnv hook fish | source
end

if type -q starship
    starship init fish | source
end

# Snap for linux
if test -d /snap/bin
    set -gx PATH $PATH /snap/bin
end
