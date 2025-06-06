vim.cmd("set noexpandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=0")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.g.mapleader = " "

require("config.lazy")
require("lazy").setup("plugins")

-- THEME
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

