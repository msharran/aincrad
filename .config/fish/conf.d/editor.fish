# Editor
if uname -s | grep -q Darwin
    set -gx EDITOR 'zed --wait'
else
    set -gx EDITOR 'nvim'
end
set -gx NVIMHOME "$XDG_CONFIG_HOME/nvim"
