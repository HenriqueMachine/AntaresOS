-- ═══════════════════════════════════════════════════════════════
--  LabOS · Neovim — keymaps extras (além dos do LazyVim)
-- ═══════════════════════════════════════════════════════════════
local map = vim.keymap.set

-- Salvar rápido / sair
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Salvar arquivo" })

-- Mover linhas selecionadas (visual)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover seleção p/ baixo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover seleção p/ cima" })

-- Manter cursor centralizado ao rolar / buscar
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
