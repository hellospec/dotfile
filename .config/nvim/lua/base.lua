-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- general setting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
-- vim.opt.smartindent = true
vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 6
vim.opt.signcolumn = "yes"

vim.opt.textwidth = 100
vim.opt.colorcolumn = "+1"
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.splitright = true
vim.opt.splitbelow = true


vim.opt.background = "dark"
vim.opt.mouse = "a"

-- vim.cmd("set ruler")
-- vim.cmd("set shiftround")
-- vim.cmd("set backspace=2")
-- vim.cmd("set history=90")
-- vim.cmd("set t_Co=256")
vim.cmd("set notimeout")
vim.cmd("set ttimeout")
vim.cmd("filetype on")

-- prevent wrong indent when type dot in ruby
vim.cmd [[autocmd FileType ruby setlocal indentkeys-=.]]

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
