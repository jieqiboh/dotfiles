# My Neovim configuration
init.lua is where I load my lazy.nvim plugin manager

Lazy.nvim looks at all the files in the plugins folder to load the plugins
Neovim looks in the folder /lua as well, so that's where I store my basic vim options and keymaps

Keymaps for the plugins themselves are located in their respective files.
General editor keymaps are in /lua/maps.lua
Editor options are in /lua/base.lua

I took some inspiration from the configs at (LazyVim)[https://www.lazyvim.org/] and (DevasLife)[https://dev.to/craftzdog/my-neovim-setup-for-react-typescript-tailwind-css-etc-58fb]

A good resource is the neovim configurations on (dotfyle)[https://dotfyle.com/neovim/configurations/top] where you can see how others structure their configs.

- adwaita: simple dark colour scheme
- neo-tree: plugin to browse the file system
- telescope.nvim: fuzzy finder
- lspzero: easy way to integrate lsps into your editor (autocompletion)
- tree-sitter: helps with syntax highlighting
- trouble.nvim: 

I generally try to keep the basic features that I would find useful in vscode, and stick to plugins 
with over 1k+ stars on Github.