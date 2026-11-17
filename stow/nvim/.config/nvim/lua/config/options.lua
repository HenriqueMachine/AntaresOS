-- AntaresOS · Neovim — options
local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.scrolloff = 8
opt.cursorline = true
-- Cursor: a block in normal mode, a thin bar when you type, no blinking (easy to find, calm for the eyes).
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,a:blinkon0"
opt.termguicolors = true
opt.clipboard = "unnamedplus"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.swapfile = false
