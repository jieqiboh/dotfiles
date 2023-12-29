vim.cmd('autocmd!')
--[[
    This command clears all autocmd (autocommand) groups. The autocmd! is a command-line command in 
    Vim that removes all defined autocommands. This is often used to clear existing autocommands 
    before setting up new ones to avoid conflicts.
]] 

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.wo.number = true -- Displays line numbers on the LHS of the window

vim.opt.title = true -- Enables the use of the terminal window title. 
vim.opt.autoindent = true -- Enables auto indentation. 
vim.opt.hlsearch = true -- When you perform a search (using / or ?), Vim will highlight all matching occurrences in the current window.

vim.opt.backup = false
vim.opt.showcmd = true -- Displays cmd being typed in the last line of the screen
vim.opt.cmdheight = 1 -- Sets number of lines to be used for the cmdline window
vim.opt.laststatus = 2 -- Ensures that a status line is always shown, even if there is only one window.
vim.opt.expandtab = true -- Enables the use of spaces instead of tabs for indentation.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.relativenumber = true

vim.opt.scrolloff = 10

vim.opt.splitbelow = true
vim.opt.splitright = true
