# tmux clipboard

Followed this to enable clipboard copy using OSC 52 escape sequence.
It is more elegant than using `xclip` or `xsel` to copy to system clipboard.
This also is simple when working with remote tmux sessions since the application inside
tmux can write to tmux paste buffer which will be copied to system clipboard by tmux.


This is supported by Ghostty, read the documentation here: 

https://ghostty.org/docs/config/reference#clipboard-write


> NOTE: We can find which terminal we are using by running `echo $TERM` outside tmux

Reference:

https://github.com/tmux/tmux/wiki/Clipboard
