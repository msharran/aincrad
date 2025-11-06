set -gx PATH $HOME/bin $PATH
set -gx PATH $HOME/sbin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH $HOME/.local/bin $PATH

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

# LLVM
set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

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

set -gx PYENV_ROOT "$HOME/.pyenv"
if test -d $PYENV_ROOT/bin
    set -gx PATH $PYENV_ROOT/bin $PATH
end
if type -q pyenv
    pyenv init - fish | source
end




if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

if type -q fnm
  fnm env | source
end

# Snap for linux
if test -d /snap/bin
    set -gx PATH $PATH /snap/bin
end

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/sharranm/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# opencode
fish_add_path $HOME/.opencode/bin

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
