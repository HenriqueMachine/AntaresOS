-- ═══════════════════════════════════════════════════════════════
--  LabOS · Neovim — opções (carregadas antes do lazy.nvim pelo LazyVim)
-- ═══════════════════════════════════════════════════════════════
local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.scrolloff = 8
opt.cursorline = true
opt.termguicolors = true
opt.clipboard = "unnamedplus"    -- integra com o clipboard do macOS

-- Indentação
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Marca sessões do nvim para o .zshrc não subir Zellij aninhado
vim.env.INSIDE_NVIM = "1"
