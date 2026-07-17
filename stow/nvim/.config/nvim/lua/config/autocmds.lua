-- ═══════════════════════════════════════════════════════════════
--  LabOS · Neovim — autocmds extras (além dos do LazyVim)
-- ═══════════════════════════════════════════════════════════════

-- Destaca o texto ao copiar (yank).
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("labos_highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})
