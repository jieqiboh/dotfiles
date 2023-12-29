# Terminal Multiplexer
I dont have any configs for it yet :3
My leader key is `<C-b>`

### Common Commands  
**servers**
`tmux` - create a tmux server
`tmux list-sessions` - list all existing sessions
`tmux new -s [session name` - create a session by name
`tmux a -t [session name]` - attach a session by name
`tmux kill-ses` - kill tmux session
`tmux kill-session -t [session name]` - kill tmux session by name

**sessions**
`<leader> + d` - detach from a current session
`tmux list-windows` / `<leader> + w` - list all windows in the current session
`<leader> + $` - rename the current session
`<leader> + %` - split horizontally
`<leader> + "` - split vertically
`<leader> + }` - move pane right
`<leader> + {` - move pane left

**windows**
`tmux list-panes` - list all panes in the current window
`<leader> + &` - kill window
`<leader> + c`  - create new window

**panes**


## Some good reads to familiarise with TMUX:
- [The Tao of Tmux (a short online book](https://leanpub.com/the-tao-of-tmux/read)
- [TTY Demystified - a neat blog post](https://www.linusakesson.net/programming/tty/index.php)


