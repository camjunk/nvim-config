-- init.lua (Neovim 0.12 rebuild entrypoint)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.globals")
require("core.options")
require("core.keymaps")
require("core.autocmds")

require("plugins")
