-- AntaresOS · Neovim — keymaps
local map = vim.keymap.set

map("n", "<C-s>", "<cmd>w<cr>", { desc = "Salvar arquivo" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover seleção p/ baixo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover seleção p/ cima" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
